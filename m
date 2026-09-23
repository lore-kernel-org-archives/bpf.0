Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08728363083;
	Wed, 23 Sep 2026 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137059; cv=none; b=GvOsrMrdswCpUG+D4exa8K9FRtnNv+sRPdZH3lGTKBxGeiDtiLLYN5qQb54A2wyJkaYpGlnIlIyvt+PxD2kNR4jJnPWgn6dE3SDYdFsfFZtevA/KwNSVzbiHXjZcsYQgQ/3y5eaXGCak95n5bOh6kBKliaheypxvH31K8NoJygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137059; c=relaxed/simple;
	bh=bFcKVfcUYkj4+QPxgYPjyeDqEzu7UnugMwi3SwfzYF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8z9iv4XYFiQDBt3W6facGdMRUT9F803N4t7AHDj5JM7P6E+fOBPBkVZSD6WtWCMBOai3PVNRABV8QArd0Sz8Z3HhrX/JZWU1u5NmWIpgSN90ShaSYght3nMtiSQjDxuunIGMoiWXI9LXsT4lRZIkBDjFuJss/A+wgsv0NIjXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n65WmTV7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n65WmTV7"
Received: from mac.lan (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 97B8320B7167;
	Tue, 22 Sep 2026 21:16:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 97B8320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790137009;
	bh=2+r73rfbt6rv80fm5u0jZU2L86+FdHUf15Te4GgmnGA=;
	h=From:To:Cc:Subject:Date:From;
	b=n65WmTV7to9SA6iTkQvC26IkYVN9lLceqNhxk5JsRKJZF1iKijp0sPGBgJuRjJyLt
	 nPQKOKoMIE6tyMtdLw1o4ll/J4hpRq1VqlCqzoCEw3zXe+sO4zFt+5ej669eSHRVlK
	 iW2pZ/9pPMEFfQzCi2esmIqHU0cXN6agEeL5or2E=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matthieu Xhonneux <m.xhonneux@gmail.com>,
	David Lebrun <dlebrun@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	Xiang Mei <xmei5@asu.edu>,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: [PATCH bpf v4] bpf: Fix non-linear SRH access in bpf_update_srh_state()
Date: Wed, 23 Sep 2026 00:17:14 -0400
Message-ID: <20260923041714.84435-1-cenzhang@linux.microsoft.com>
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

Fix this by pulling the complete SRH into the linear head before it is
dereferenced. Pulling can reallocate skb->head, so refresh the BPF data
pointers inside bpf_update_srh_state() immediately after the pull.

For End.DT6, make the inner IPv6 base header linear before removing the
outer headers. Pulling only the outer headers can leave the inner header in
non-linear data, while ipv6_find_hdr() and the nexthop lookup access it
directly. The helper parameter may point into packet data, so copy the
table ID before pulling and potentially replacing skb->head. Clear the
cached SRH pointer and refresh the BPF data pointers if the pull fails.

End.B6 and End.B6.Encap can insert a new SRH and reallocate the skb before
a later HMAC calculation or nexthop lookup returns an error. Rebuild the
SRH state when the skb length changes, which indicates that the new SRH was
inserted. Failures before insertion leave the existing state unchanged.

Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action helper")
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/bpf/20260901183151.16648-1-cenzhang@linux.microsoft.com/
Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
Link: https://lore.kernel.org/bpf/CABFh=a5iLOEJdPhoaWUhLc0eEqAuhnd83_jJr9MVZZG6gSJAEw@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CABFh=a4VyzxsQqsayWpTKjxY3HL2C072u=pbecEpNDbL9eBNKA@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CAADnVQJceTGftun8NfbyQdWe1FqLDsd6Ut5mrQFxuVkAvrAAEg@mail.gmail.com/
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
Assisted-by: Copilot:gpt-5.6-sol
---
Changes in v4:
- Keep ipv6_find_hdr() and only add pskb_may_pull() instead of switching
  to seg6_get_srh(), which also validates the SRH. (Alexei)
- Rebase onto the current bpf master branch.

Changes in v3:
- Copy the End.DT6 table ID before pskb_may_pull() can replace skb->head
  and invalidate a packet-backed helper parameter.
- Rebase onto the current bpf master branch.

Changes in v2:
- Rebuild the SRH state after End.B6 and End.B6.Encap only when the skb
  length changes, avoiding selection of a spent Routing Header on errors
  before insertion.
- Rebase onto the current bpf master branch.

 net/core/filter.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..1aaaa6c51745 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7019,13 +7019,16 @@ static void bpf_update_srh_state(struct sk_buff *skb)
 		this_cpu_ptr(&seg6_bpf_srh_states);
 	int srhoff = 0;
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0) {
+	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0 ||
+	    !pskb_may_pull(skb, srhoff + sizeof(struct ipv6_sr_hdr)) ||
+	    !pskb_may_pull(skb, srhoff + ((skb->data[srhoff + 1] + 1) << 3))) {
 		srh_state->srh = NULL;
 	} else {
 		srh_state->srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
 		srh_state->hdrlen = srh_state->srh->hdrlen << 3;
 		srh_state->valid = true;
 	}
+	bpf_compute_data_pointers(skb);
 }
 
 BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
@@ -7033,6 +7036,7 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 {
 	struct seg6_bpf_srh_state *srh_state =
 		this_cpu_ptr(&seg6_bpf_srh_states);
+	unsigned int old_len;
 	int hdroff = 0;
 	int err;
 
@@ -7050,40 +7054,49 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
 		if (param_len != sizeof(int))
 			return -EINVAL;
 		return seg6_lookup_nexthop(skb, NULL, *(int *)param);
-	case SEG6_LOCAL_ACTION_END_DT6:
+	case SEG6_LOCAL_ACTION_END_DT6: {
+		int tbl_id;
+
 		if (!seg6_bpf_has_valid_srh(skb))
 			return -EBADMSG;
 		if (param_len != sizeof(int))
 			return -EINVAL;
+		tbl_id = *(int *)param;
 
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
-		return seg6_lookup_nexthop(skb, NULL, *(int *)param);
+		return seg6_lookup_nexthop(skb, NULL, tbl_id);
+	}
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

base-commit: 6db1ce73e9853f533eb7f413f14ba00f8ec6f80d
-- 
2.53.0

