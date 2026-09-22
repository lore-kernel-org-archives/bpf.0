Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27525577E47
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097650; cv=none; b=u1NesfTspdCbS8+/Gs2LV69mGlkP4QFE32szUbUwSTO7qslfWkePqx2itYHa5cznIwr8IMZ1vKlJI9tdwyFECt/H46oM2z61d9safF4JeGg8T201yqqCMmoKqV6tE7X+wcx4RaiWevM2bHgEYwCvDR+9vOkOHsLUm9/8hVAqKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097650; c=relaxed/simple;
	bh=L9TmFUkltNMaiDYftOPLxaplpNe94rPN0sOUsEh0AFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jdp1I6MAisLOCL07P75DIuDruW+0P0PN+mciJrZlTAyp5w3bnact2EeAWKZhg4UJk2V6bgjlz5vgjMaQC6N+bLL/L/abcSPivExo1luWJqKMXKaXFxe6nv4eZQyQXarxABuRWmaf3eXSjSxMSV8CidEF8dgev370Rl/SAzDXqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=S9ihpjPc; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="S9ihpjPc"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so122052a91.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097644; x=1790702444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hl3c77EoYM1aOqZiOf7+XyVVsyKQOXFXmz+T1DEuNRw=;
        b=S9ihpjPcDbr+DDxLID3solQr7AQwKf3G6Mnht7wl8BH/1Z2SafUupSW12QppAdY4vh
         kKP4JYfETLtzJXlT5hvUMAHeEEhM/XIMkeTzQexFRy07+/l4ur4DnPlwVs8k2pYaFt1y
         Z1Hg5lZphTyJ3gET6IGPI5APFHv/e5/Yx7PCPdeJK9csL40BOfJBnJv7FsOgX+tO7JOQ
         jnx8IFS5Sf1x9cqKNywmW33qnr5Vl/8TW50Rr4MXHAWP7ftZ3D9BLMJgIvXVX8JqRUkE
         xXOel5K131A7tX+DJlRrT0jv158pOzXtN4d/q80x06jkSUY9YBYOhiaDg6WdJjnJtChT
         CLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097644; x=1790702444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hl3c77EoYM1aOqZiOf7+XyVVsyKQOXFXmz+T1DEuNRw=;
        b=iJezbY1hvLMaR1GCFV8WwIH2IKbouzPaweCsnnmDAMYMES28pVQ2VMb74qezEzMrA1
         sO7izsQAViwzZmtJfdy5V2XM16COIPbApoKu89INHXYHntO1UU1/uacBYjRNSZFhdW2F
         6RJ8MdGqcL2CNhE1B0pHz+W9cWrtVRMSG4S8RbR6qXsDgfHpQkmU6sL4iBepGtAb0B/J
         6+zSxY68flzlHDz4NlsAz5bKk7cbeN+hbRqdgh4sGgQWrcCQkHuquKgR1RIWykzOcUlb
         PYOGcUz2AMZTkfRgtnx2JXYjsW//7843aF8jPU3WZboJDQqtYtAztiSo1TijJbGFN4aZ
         JUAA==
X-Gm-Message-State: AFuF++n7XfbloTtnNKBD3xc0bK9rEAqTF8pCFg5azucAD7gX9qEQL9hx
	YfGMlWsPIfrgplbuFTgqjKQ4qX2Vg+VQ/m6GzmE2Q9H/gFGbLqfT2T4Q5fbmdW4/6C3XUnx37K3
	pZQUH
X-Gm-Gg: AYBFou1QON84n0MnSdTrBTSYi8IYDA54HtynSwRQek6jsEau184spLuCmq3HB4ZAAij
	6KDnUSe7kfIbMllQhhnqFeTrWlsBZ7GEpuAJ8ef3rCbZCoIGXz1kKdT5mzVO5bSAHkGDGr7I4bn
	hCVKq66pA3jXTozSO37JX+rBOVU9p4Sl+g6IDkxZ3Ud6wcdg78Ty8UAhMpczRwtCuhYQ20+nBDt
	+SsIx58fWePkFlT0AZYjdNtB7DOdGoZVE8ivo3PBu69IIcKXhw/vOg8GiMNI0lvtkqfMrCh9M5g
	h3jxzFwnuq0wsJMO3o051tpb1JPYrJB+UhTPhlYsBJlxoykAAIsvDujKMVqJ1HuNkaKJwj/XHso
	MsAxoYSjuj7WO2u8VtrjYj2eCiRVixww+srdLcFFs135VEy3ObEm12UZUdkvIzb3qW83yHODWVY
	7osrEQHE1nVFPOCa1y3PI3D3F+eGDxwTnYVp7II1oUYJnDbTD7HnOyezTSVK+9OgS48DyMZmKLg
	OMivz4jUR8iMfHKOBnesDSRFCtGQa8+EspebU4seg==
X-Received: by 2002:a17:90b:2ccc:b0:39e:58e4:dc2f with SMTP id 98e67ed59e1d1-3a07e56753amr137778a91.5.1790097644466;
        Tue, 22 Sep 2026 10:20:44 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH bpf v2 05/11] bpf: Reject pkt arguments in mutating subprogs
Date: Tue, 22 Sep 2026 17:20:22 +0000
Message-ID: <20260922172028.6269-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier tracks changes in how PTR_TO_PACKET registers'
bounds are modified across subprog boundaries. PTR_TO_PACKET
registers are actually passed as PTR_TO_MEM, which is assumed
valid for the entire call. This is not the case with packet memory,
where a pskb_* call may invalidate its memory region.

Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKET
because we would also need to somehow pass the PTR_TO_PACKET_META
or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representing
the pointer in the subprog as PTR_TO_MEM, only permit it if the
subprog is guaranteed not to mutate the packet.

Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Suggested-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d62c0f74c..71ad07a9d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10421,6 +10421,16 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL,
 					  NULL))
 				return -EINVAL;
+			/*
+			 * PTR_TO_PACKET get passed as PTR_TO_MEM, preventing
+			 * us from adjusting bounds tracking info.
+			 */
+			if ((reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) &&
+			    sub->changes_pkt_data) {
+				bpf_log(log, "%s is a packet pointer, but func#%d may change packet data\n",
+						reg_arg_name(env, argno), subprog);
+				return -EINVAL;
+			}
 			if (!(arg->arg_type & PTR_MAYBE_NULL) &&
 			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
 				bpf_log(log, "%s is expected to be non-NULL\n",
-- 
2.54.0

