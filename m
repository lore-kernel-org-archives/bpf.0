Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560057;
	b=3FfDLTHYStQFODqL8tMwJtuLooBJ1VqKT01Ir6lNFSMduAiAwYX53GHG0VZTUtgpzHqC
	 ClYYYuECs1WbwVBSJiIZJ7z8JKPLyFP8q6jm92aCKWAkqP3HuTzyDi805VeG3dSSnuV7b
	 xnMEmMkpuqXcfyK8XFoAskPcd0QxBtyJ0CaKsSYvmAisauSjL8UYrh8uP3+5jp5M6nK52
	 OcEusHDqFri2DB/94byGhP+of4L/A2zgah+DaxrTHRK/pwIu+nEPaPP+ljY7+Ma1v7J9R
	 El7zI/qQcOW5pl4ZmArTcfL1XyRO9bWEIwCfhn1XndolVLdy18NRllwa08k56o3Hh9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K0D2xwRbxCogYwcx97ILZNFff1Y/X2ey7+sSmv2zYYM=;
	b=hFyCRD4bYVDAUegMRctpivZgh0rLGPDlLNyHV75bpwpHvTY8BOv7bD9PTDs8/V9rS5TC
	 2oA3xSklL+BFM8DkDxLVwrMP0NuD9ZZrNW6DyXTFXxlwXDPsqOncXlqezGHKEmuLHKIMv
	 pc6dycVMb/62JLtBCgS9AgtpI/AmRGfsJQAAb6krWDbNjoSMQumqsiBbrkMdAFPL1B/yI
	 yWfLTVA60bSSK9bskGv7WVO3KRKW2rPP3/30CSRMwaVrr/vqMEUI0Rm5lAYmlIbw8IoIe
	 ZawCAW28O0Fc/hqOOPO8DWsiucsrRC+y4hvzMhFWk0A9RdB5PCtSBMVzj+YKiuGMpDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=deTYmOmB;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE05C606A334
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE05C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=deTYmOmB
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06b436dffso506848b3a.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560051; x=1794164851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K0D2xwRbxCogYwcx97ILZNFff1Y/X2ey7+sSmv2zYYM=;
        b=deTYmOmB9a/NoVrMToiK+EglyvNKWkDfCpqv53U1U4ggLGIWjg7o6cmrBOE0oIGZm4
         FB1t+61rzcfWMGD0y36nvf5igJstjdbGobl7QNDBGcnN+Qv3pVKHBKjpTS5zM9G6ZVjO
         IdndhfuSo/AwUzQYGWiXKyvfFv3yh4hmY5rj68wFroEUGvm62D06icgo001Wg+10fy4b
         uafafYG1uignGG7YXqSLIR88+xp/DjlJFJ1Db6e8H5D/RnBTDjldJtXzXDtV4ideuOnj
         ffxmzwLfdqjaWXbJfNnEkD708peMtUswbLiSfiHpEpPe2Myr72Q7xF6Rgd5KW67kOLYs
         93hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560051; x=1794164851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K0D2xwRbxCogYwcx97ILZNFff1Y/X2ey7+sSmv2zYYM=;
        b=sLsEFvqPUcgl6Lgo7LUG1TYDSqn9w5Kl/Zx8ZztqiIVUxiewZQXg/prLWauP9uJtpo
         /Rt71usLCvEFH9FF8llpbodzNtG62WX0lNNDFFvncy7+WCUsB6dHvfnQxev4NrtkMwQ+
         wESLEVb9cc9rEGptv2Td55IBmRUg8KVhlCA5D6QUad+21x488gf6nZt8JRXRDScG02Ot
         CixExxk3J/6H+LkQJjDDfVXQIAmkD9va/WCJnNI8cJiNiqGckp3iqBT53gWSf+LltF5j
         SN76zRWRHFqemXs4tSbepF5KQSTGGwmHktYADGU1LkQb2YJvYclayVHF0PH3oIjQCmr4
         IKDQ==
X-Gm-Message-State: AFq9FYK3b0D9UBwg3W+fbm2ibLvtFL7AGsvka9S2JuYXfQPUHUqsKAf/
	+uFG425uE5keeB4uGWol7NCSI9UoPQKG2GVg6MxnaWg6VefvEaq/xu1H+Bjoyg==
X-Gm-Gg: AYBFou2arEo/mCsRfDp9Pq4rdy1tmV9W0Fd5+9amDVLwq9J3pCOJYCjU6GeW1WrqbiB
	YDQz0KTLip2xw2+FEn0Ek2s0YzqGrYCcze0fDOey+UY3Z0fUopFLLc+xAlhSFacD7Np33tR3WN6
	ualZgAibE0FErJ5eA6PI8XAL+fumjP0WjGrT/TvTzWKfv5ERbIxxJ9W0K0xg+vKyCGR4QaqNGft
	yMX2Og4ijKlkvSJu98yZPfb1mue8zfhasC5D1XgJLLXC1jkVghgliiWUBbzxh2hUxzAeWDM/Hdz
	svH1vhrMma305cIA/xSzkS9j+4CzCTWpYcBCIFtW4TKdlgU0w7qnVtElH/LGXX8qdcStSp9+yyC
	C347+aAEV28B5dzuXCUmrEP+FO3f0uJpGC2v4CciUs3T1eL07xwaMaA31PCZ0VxkKX5RG9U5+1F
	kYaEScsbVics5EoUVUZYQtjEq1vwZnm+zzoe2nIBq84FoiWMLdhPvdaxb2q/sHOrWvxjeFSRpmf
	hERPo7zg3C5Ntp8DzqHQnk9Os6uC4wsFSgHtmGBbvg7cBty84qAPGuCvZku2K7zoJgqDPq6iJC2
	5iKE3GszXZy/hQLJksnHo10G+QCb7r8nM9tnqy8s8hL0UTgbCuVN2A9JrpLzSbD7OesQbtW5wm6
	F36mORdwpi4fLkEZR6CbF/Vnv6o4oaqui3AG/BDkxezCA+HUlFw5w3c0yf+bTOMTtD1soTFLseh
	jr8BPKujfwYoBdLB55tn/E
X-Received: by 2002:a05:6a00:288c:b0:88b:7712:6e21 with SMTP id d2e1a72fcca58-8a9bf71b338mr6745520b3a.33.1793560051282;
        Sun, 01 Nov 2026 11:07:31 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9637134sm1165443b3a.11.2026.11.01.11.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:07:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 19/27] bpf: Don't look for the SRH again in the End.BPF helpers
Date: Sun,  1 Nov 2026 19:05:27 +0000
Message-ID: <20261101190535.1454146-20-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A packet can have two SRHs. Thus input_action_end_bpf() uses
IP6_FH_F_SKIP_RH to skip routing headers with segments_left 0. The helpers
bpf_lwt_seg6_store_bytes() and bpf_lwt_seg6_adjust_srh() can reallocate the
head of the skb. Thus they look for the SRH again, but without this flag.

  +------------------------+ <- the helpers: srh_state->srh
  | SRH 1, segments_left 0 |
  +------------------------+ <- input_action_end_bpf(): srh_state->srh
  | SRH 2                  |    and srh_state->hdrlen
  +------------------------+

Then the helpers check offset against the wrong limits. If a helper changes
TLVs, seg6_bpf_has_valid_srh() writes the length of SRH 2 to SRH 1.

Neither helper changes the offset of the SRH from skb->data. Calculate the
new address from this offset. To add IP6_FH_F_SKIP_RH is not sufficient,
because advance_nextseg() can set segments_left of SRH 2 to 0. The helper
bpf_lwt_seg6_action() can change the headers and still looks for the SRH.

Fixes: fbbc5bc2ab8c ("seg6: ignore routing header with segments left equal to 0")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index acd1e89351d6..d634850a38c7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7024,12 +7024,13 @@ BPF_CALL_4(bpf_lwt_seg6_store_bytes, struct sk_buff *, skb, u32, offset,
 		this_cpu_ptr(&seg6_bpf_srh_states);
 	struct ipv6_sr_hdr *srh = srh_state->srh;
 	void *srh_tlvs, *srh_end, *ptr;
-	int srhoff = 0;
+	int srhoff;
 
 	lockdep_assert_held(&srh_state->bh_lock);
 	if (srh == NULL)
 		return -EINVAL;
 
+	srhoff = (unsigned char *)srh - skb->data;
 	srh_tlvs = (void *)((char *)srh + ((srh->first_segment + 1) << 4));
 	srh_end = (void *)((char *)srh + sizeof(*srh) + srh_state->hdrlen);
 
@@ -7042,8 +7043,7 @@ BPF_CALL_4(bpf_lwt_seg6_store_bytes, struct sk_buff *, skb, u32, offset,
 
 	if (unlikely(bpf_try_make_writable(skb, offset + len)))
 		return -EFAULT;
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
-		return -EINVAL;
+	/* The head may have moved. */
 	srh_state->srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
 
 	memcpy(skb->data + offset, from, len);
@@ -7162,13 +7162,14 @@ BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff *, skb, u32, offset,
 	struct ipv6_sr_hdr *srh = srh_state->srh;
 	void *srh_end, *srh_tlvs, *ptr;
 	struct ipv6hdr *hdr;
-	int srhoff = 0;
+	int srhoff;
 	int ret;
 
 	lockdep_assert_held(&srh_state->bh_lock);
 	if (unlikely(srh == NULL))
 		return -EINVAL;
 
+	srhoff = (unsigned char *)srh - skb->data;
 	srh_tlvs = (void *)((unsigned char *)srh + sizeof(*srh) +
 			((srh->first_segment + 1) << 4));
 	srh_end = (void *)((unsigned char *)srh + sizeof(*srh) +
@@ -7200,8 +7201,7 @@ BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff *, skb, u32, offset,
 	hdr = (struct ipv6hdr *)skb->data;
 	hdr->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0)
-		return -EINVAL;
+	/* The bytes in front of offset have moved together with skb->data. */
 	srh_state->srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
 	srh_state->hdrlen += len;
 	srh_state->valid = false;
-- 
2.55.0

