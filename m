Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E63A0E85
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255138; cv=none; b=sb+p6Wv88mjjWFofLsWI8HX5YRJzJRaHA8JoIPOM+ER5X0XMpJ6XzOyFmsp9HZ3FmtOhrKQfXHoOybJC9Z1HXPW9OeX5v8DEpfBSajLUZSnd5H1x1etRAqKOEC6IP5IpekdRnvwH9u/3NkYAELFvlXr7oVgy2czD+cKGjtofK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255138; c=relaxed/simple;
	bh=jmaWeyIveisSzZ7aCwrfiBdfaBQ6cxntCG0EieSF8SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8Za5K+GA7QQc/QAEAtOKg/pWmk1CsUCIGFtXEXrH3CxwglfSjQ4VPwtqqJhZlmlSuOSbs26ZFyCmMwW8+EbriTTT+iwPRgcBUM5WOIqXWOZuc5JlWKP+E/CJJu/6iBr0qpuJ7g++/WqEgsDG4Tmmyel+FkWTQ6pCUyW6s5mqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBbgidyO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBbgidyO"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e987a2ba0cso6129835ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255136; x=1792859936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NoQnwU23qouoapgLxBv+Bhz2dTNvqCRZampt5Twechk=;
        b=DBbgidyOSk2d9WrV+Z5GiFPvHDuBAaTfQqWyRcRdpl21/AUjRsIWPHy6YsQE8VN+JR
         c4a7PQhBiIAhhoE9G7My6yDb+K/juQVg50WBMZvRp7GTLHHyAJuaM06swrA+vPQ/mhTN
         7mhIUqEnN9cTDzMg6WQaiyMPlOZgKqT0uYBU82BSCsQnOttIaWtZZA9jQjdDgTsAcTwG
         Q4mwUwo48qqxd1zudq6h3ZgWV3ydpAwfeILiNedBUs9Ey0M6Qk8BAQVzNgGTCtvrbjF5
         xYjwvEjZkNBr20j6ZYlY8/7OF9I/eEjbsY3Nv6TVwRinmaTEglhuXq0pE545ZHV9/VK0
         y9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255136; x=1792859936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NoQnwU23qouoapgLxBv+Bhz2dTNvqCRZampt5Twechk=;
        b=jDJtAwL9I71TW8o7YCXVEvy/bL/BdypdNjT2XOPrUHgeVPXXT1OAHf1YV23WwYSoqV
         NOtik58TiSH6jQz7/HEDeINUp8bXdlL9dJz1I9YD/85nUIXFirHfcp6/V0RWTTgMvNwm
         i4X8IMQ0mZQ8hfJAsPMeZum4Kj2UY0JMGJoUAfhf26T1FQF0Tbt055awL0L6p5enwiJe
         u2wG34RemY7C6MB8foSHPDFHXFTsYdIboHPMmIAHWNwXrWeozL2x6WYunqEjlqfzXKa3
         MogJxsyE3uNy3rVEwlU1wZVdWUPJ8DglUS/x6wdriMO+vJ2x8+nEnRDxOy6RvwDSi1JV
         QWsw==
X-Gm-Message-State: AFq9FYKxbmmSK/Ythvev9uS8np+Fwucc3ztKl2DxFdC56mMJ7B9qqJRe
	7vYWIhh1c3KhYYiXTjOmT+hDla+xMP/eOZOGzErWynazK7GBb7nbawadxU4h/Q==
X-Gm-Gg: AYBFou1pNUsMubWOcw1K947jS8vf9ctDxcUbaxb64kf+wJ9Z7tGlJLeiofYPtoFdEzz
	dzSM1NY7h4E3NLXJitzKubsTZT8AtzO3MtCpEg2uuTgtkuyz+JMqfu0SkyyeODVTccerDF9+tiL
	5qepvQfok+lJwHyAG+szFXqNMsjwD+zXQstLSe0X1oHnnA46GfV4kaiAOGR22MDRv0387vyhDFo
	4YHPyATTEIJZJQ85/pNTXQz3vJWwphMbuNKF6gad9H/89SM8Gmb97ixHlBke+waDCsC1c3Ae4XN
	QMzGzzta5f7h3ScPN6O6aP1s2RuhghJMFTpGqjvp95wCmPoRCr/VF1KZeepTehfLHiphhwIGc9j
	6raMCBy9z26ndVysciN1iQDWpO21WaEDvZGjHRl95xWz6QAJmrzbBk3rvibF2oUA24y2wj5j72K
	Irj/7YUVAk1hxmyAM3U+0BUcFUhykVV21aK2y/yxko+Znk2mG9nlbYGGJ0tjpRMuQrxwdUV5R/J
	aJALzNSdGA7uKZGHezp0hXiQFbqsFgGF10p7TiVmOifDtgQand6nYW6QWITODMt5CSVmTJwjkNQ
	uj0kkt/4ja2QPI+Ic8rmoNieYce592KcFCBn27Pj0gY=
X-Received: by 2002:a17:902:e547:b0:2e8:93b5:c555 with SMTP id d9443c01a7336-2e9a6e5296emr27675065ad.61.1792255136209;
        Sat, 17 Oct 2026 09:38:56 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8997edsm22735055ad.63.2026.10.17.09.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:55 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 11/43] bpf: Validate the SRH which End.DT6 uncovers in End.BPF
Date: Sat, 17 Oct 2026 16:37:13 +0000
Message-ID: <20261017163745.3341787-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

input_action_end_bpf() validates the SRH of a packet and pulls it into the
head before the program runs. If the program decapsulates the packet with
bpf_lwt_seg6_action(SEG6_LOCAL_ACTION_END_DT6), bpf_update_srh_state()
looks for a routing header in the inner packet and takes it for the new
SRH as it is.

Nobody has looked at that header, and whoever has sent the packet has
written it. ipv6_find_hdr() finds it in a fragment of the skb as well, but
hdrlen is then read at that offset from skb->data, past the end of the
head. The header need not be an SRH, and its hdrlen need not fit into the
packet, but it is marked as valid, and bpf_lwt_seg6_adjust_srh() and
bpf_lwt_seg6_store_bytes() check their offsets against it.

A program which then adds a TLV at the end of the SRH, where hdrlen has it,
makes bpf_lwt_seg6_adjust_srh() move and write memory behind the head of
the skb, as far as the sender likes within the 2 KB that hdrlen can say:

  BUG: KASAN: slab-out-of-bounds in bpf_skb_net_hdr_push+0x185/0x240
  Read of size 2088 at addr ffff888107d6f09e by task srh/102
  BUG: KASAN: slab-out-of-bounds in bpf_skb_net_hdr_push+0x1b5/0x240
  Write of size 8 at addr ffff888107d6f8be by task srh/102

Use seg6_get_srh(), which pulls and validates the header. Without a valid
SRH the state says that there is none, and the packet goes its way as
before. The pull can move the head, so compute the data pointers behind
it.

Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action helper")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index dc630fc9f3eb..a62f3decf1e2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7025,15 +7025,15 @@ static void bpf_update_srh_state(struct sk_buff *skb)
 {
 	struct seg6_bpf_srh_state *srh_state =
 		this_cpu_ptr(&seg6_bpf_srh_states);
-	int srhoff = 0;
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0) {
-		srh_state->srh = NULL;
-	} else {
-		srh_state->srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
+	/* Behind a decapsulation this is a header that nobody has looked at */
+	srh_state->srh = seg6_get_srh(skb, 0);
+	if (srh_state->srh) {
 		srh_state->hdrlen = srh_state->srh->hdrlen << 3;
 		srh_state->valid = true;
 	}
+	/* it may have been pulled into the head */
+	bpf_compute_data_pointers(skb);
 }
 
 BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
-- 
2.55.0

