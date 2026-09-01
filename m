Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3BC49C4D7;
	Tue,  1 Sep 2026 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287539; cv=none; b=Ky7wHIk0l5g+ZivCskgO5N98BvYNBIF9wc0rpjwZQ1q1ogtJDTVppdlkJIP9gBHeUmBY/cm2lE6xfdc9Vg1q5T0n3/nsRMSMfWC7M/04K+7gX5R/pwSlhUjd9vCIOjxO9eJmut3J1hfI2gFaKuF65g5ghgHCKd5TazJGPY9QNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287539; c=relaxed/simple;
	bh=8reCUJxOb/qiB+cku2vUyWN31+NCse2ORArB6WC5hQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ups9ZKWq3GiWf+/yal+Uk3o2oZkAMvxadGf1sfnf4wJpOyUQvs5mEdQMGv1+vmt5in9uJOHyk1FHYgqzrnqfNeJRvH5xttvfRZSTt31GdyiIGmGCEt520vZgjmy6KVkB04JEHoSJUCMyqy1x6wpMCwbBIRAqC0VHtMfwgiHStBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F5u3BfXZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F5u3BfXZ"
Received: from localhost.localdomain (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8739B20B7166;
	Tue,  1 Sep 2026 11:31:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8739B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788287500;
	bh=g8biAfnBAtHVVulWCEtHx8nTG/a9ja9DfpALIQzmWfg=;
	h=From:To:Cc:Subject:Date:From;
	b=F5u3BfXZ87uNS3bobSRml73sveXDPb5RnEMM1gloYl+AjLQbCerFws86e9vVLGDrX
	 tYmSkWQbhR4QRyAf9hXJsVDxN33I2vgXJ4AEgN9spUwxME1GFXDc+W1krYTZ+DNe9h
	 vUM+7nqW6XwuWahY5DwUDd61HmRDoUdWTuxvZV6E=
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
Subject: [PATCH bpf] bpf: Fix non-linear SRH access in bpf_update_srh_state()
Date: Tue,  1 Sep 2026 14:31:51 -0400
Message-ID: <20260901183151.16648-1-cenzhang@linux.microsoft.com>
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

End.B6 and End.B6.Encap can modify or reallocate the skb before a later
nexthop lookup returns an error. Rebuild the SRH state regardless of the
action result instead of assuming that an error leaves the skb unchanged.

Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action helper")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
Assisted-by: Copilot:gpt-5.6-sol
---
Please queue this fix for stable kernels.

Testing:
- Static checks only: checkpatch.pl, diff --check and patch replay.
- No targeted selftest was added. BPF LWT test-run does not support
  non-linear skbs, and the existing SEG6 netns test does not create a
  split inner IPv6 header for End.DT6.

 net/core/filter.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..1dd3a685d1b8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7018,15 +7018,16 @@ static void bpf_update_srh_state(struct sk_buff *skb)
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
@@ -7059,15 +7060,18 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 
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
@@ -7075,8 +7079,7 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 			return -EBADMSG;
 		err = bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6_INLINE,
 					  param, param_len);
-		if (!err)
-			bpf_update_srh_state(skb);
+		bpf_update_srh_state(skb);
 
 		return err;
 	case SEG6_LOCAL_ACTION_END_B6_ENCAP:
@@ -7084,8 +7087,7 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 			return -EBADMSG;
 		err = bpf_push_seg6_encap(skb, BPF_LWT_ENCAP_SEG6,
 					  param, param_len);
-		if (!err)
-			bpf_update_srh_state(skb);
+		bpf_update_srh_state(skb);
 
 		return err;
 	default:

base-commit: 28d75dd3eb60812b3a87cbdf0d52c42f51b28a78
-- 
2.55.0
