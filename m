Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DBC545D82;
	Wed,  9 Sep 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962032; cv=none; b=XTOW6vE6Ev2WWR8zGhSGFRFarO1BCjCH6Vx4V6nO9lz/D9Z+O/S5JKjOGR0vZcSwgfGmboFne0IF/A2G3mdYXC5KB1tjGAgz0lPNs+yqwem/GQM3u9v1I8tqopjSstS9vninvViDBO0ZCeow/OMceCvIIGgsVBEZojIDSK0qDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962032; c=relaxed/simple;
	bh=3l7lMquNmVfJX9gEHjGJPlkgwN50l3+CQX1vYtz0ETw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmsD0K8IFmHfGQC98TJjT8P27pKikVSvxAY5eGkb9BQhctL5qZ4IUMuyDoazAIPqDzV6QDmSeEYoRjCZJmkFfx7mBJBo4zDeJ4Yenp6N3zBnBG58fMCe4VDa4qDfyPUTcv9clu4rHJlld1m8vE6qNN6gWmHJaqngCr0b68pPdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FcoSUCK8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FcoSUCK8"
Received: from localhost.localdomain (unknown [52.172.102.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id A83CA20B7128;
	Wed,  9 Sep 2026 06:52:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A83CA20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788961989;
	bh=Uv2isFaho/0/l3FkvZ8496hJ7fuZ5VFJCs6DWazZhUs=;
	h=From:To:Cc:Subject:Date:From;
	b=FcoSUCK8WKu0+rHf+4j4iS6pSk7bzsGx1enChBSOLOTq0UspCbee/BathcryPYgAL
	 nUCw0wVov56aSPv4eZt4hVoVZVwsbncJBrNeNwt2Yl6AlWFMECsc8MiJ8NRIuYZQBQ
	 yQKbnCnqJwpRsPHaY1rbp0IPGwcVMhT+LMXWdllY=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	m.xhonneux@gmail.com,
	dlebrun@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
Subject: [PATCH bpf v2] bpf: Fix non-linear SRH access in bpf_update_srh_state()
Date: Wed,  9 Sep 2026 09:53:24 -0400
Message-ID: <20260909135324.60165-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_update_srh_state() locates an SRH with ipv6_find_hdr() and caches
skb->data + srhoff in the per-CPU SEG6 BPF state. This assumes that the
returned offset is within the skb linear head.

That assumption is wrong because ipv6_find_hdr() uses skb_header_pointer()
and can locate an SRH in non-linear data. The direct srh->hdrlen read and
the cached SRH pointer can therefore access memory outside the linear area.

BUG: KASAN: slab-use-after-free in bpf_update_srh_state+0x1bc/0x200
 net/core/filter.c:7027 bpf_update_srh_state()
 bpf_lwt_seg6_action()
 input_action_end_bpf()
 seg6_local_input()
 ipv6_rthdr_rcv()

Fix this by using seg6_get_srh(), which pulls and validates the complete
SRH and reloads its pointer afterwards. Pulling can reallocate skb->head,
so refresh the BPF data pointers inside bpf_update_srh_state() immediately
after the call.

For End.DT6, make the inner IPv6 base header linear before removing the
outer headers. Pulling only the outer headers can leave the inner header in
non-linear data, while ipv6_find_hdr() and the nexthop lookup access it
directly. Clear the cached SRH pointer and refresh the BPF data pointers if
the pull fails.

End.B6 and End.B6.Encap can insert a new SRH and reallocate the skb before
a later HMAC calculation or nexthop lookup returns an error. Rebuild the
SRH state when the skb length changes, which indicates that the new SRH was
inserted. Failures before insertion leave the existing state unchanged.

Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action helper")
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/bpf/20260901183151.16648-1-cenzhang@linux.microsoft.com/
Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
Link: https://lore.kernel.org/bpf/CABFh=a5iLOEJdPhoaWUhLc0eEqAuhnd83_jJr9MVZZG6gSJAEw@mail.gmail.com/
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
Assisted-by: Copilot:gpt-5.6-sol
---
Changes in v2:
- Rebuild the SRH state after End.B6 and End.B6.Encap only when the skb
  length changes, avoiding selection of a spent Routing Header on errors
  before insertion.
- Rebase onto the current bpf master branch.

Please queue this fix for stable kernels.

Testing:
- Static checks only: checkpatch.pl, diff --check and patch replay.
- No targeted selftest was added. BPF LWT test-run does not support
  non-linear skbs, and the existing SEG6 netns test does not create a
  split inner IPv6 header for End.DT6.

 net/core/filter.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8513167a858a..b037d70e5fe6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7017,15 +7017,16 @@ static void bpf_update_srh_state(struct sk_buff *skb)
 {
 	struct seg6_bpf_srh_state *srh_state =
 		this_cpu_ptr(&seg6_bpf_srh_states);
-	int srhoff = 0;
+	struct ipv6_sr_hdr *srh;
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0) {
-		srh_state->srh = NULL;
-	} else {
-		srh_state->srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
-		srh_state->hdrlen = srh_state->srh->hdrlen << 3;
-		srh_state->valid = true;
-	}
+	srh = seg6_get_srh(skb, 0);
+	bpf_compute_data_pointers(skb);
+	srh_state->srh = srh;
+	if (!srh)
+		return;
+
+	srh_state->hdrlen = srh->hdrlen << 3;
+	srh_state->valid = true;
 }
 
 BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
@@ -7033,6 +7034,7 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 {
 	struct seg6_bpf_srh_state *srh_state =
 		this_cpu_ptr(&seg6_bpf_srh_states);
+	unsigned int old_len;
 	int hdroff = 0;
 	int err;
 
@@ -7058,32 +7060,37 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 
 		if (ipv6_find_hdr(skb, &hdroff, IPPROTO_IPV6, NULL, NULL) < 0)
 			return -EBADMSG;
-		if (!pskb_pull(skb, hdroff))
+		if (!pskb_may_pull(skb, hdroff + sizeof(struct ipv6hdr))) {
+			srh_state->srh = NULL;
+			bpf_compute_data_pointers(skb);
 			return -EBADMSG;
+		}
+		__skb_pull(skb, hdroff);
 
 		skb_postpull_rcsum(skb, skb_network_header(skb), hdroff);
 		skb_reset_network_header(skb);
 		skb_reset_transport_header(skb);
 		skb->encapsulation = 0;
 
-		bpf_compute_data_pointers(skb);
 		bpf_update_srh_state(skb);
 		return seg6_lookup_nexthop(skb, NULL, *(int *)param);
 	case SEG6_LOCAL_ACTION_END_B6:
 		if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
 			return -EBADMSG;
+		old_len = skb->len;
 		err = bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6_INLINE,
 					  param, param_len);
-		if (!err)
+		if (skb->len != old_len)
 			bpf_update_srh_state(skb);
 
 		return err;
 	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
 		if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
 			return -EBADMSG;
+		old_len = skb->len;
 		err = bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6,
 					  param, param_len);
-		if (!err)
+		if (skb->len != old_len)
 			bpf_update_srh_state(skb);
 
 		return err;

base-commit: 15e2565f1c43771af0bc5324971cabaad79ac286
-- 
2.55.0
