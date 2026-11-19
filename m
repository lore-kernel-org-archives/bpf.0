Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107320;
	b=3BVCpa00CCC2U8y6IzCp4UWyKoF21+VMfOYaSwONKZ/WbTwwVIAL7a+ULPzKAFaQC8iF
	 Mc6GXD/0XKjYKOd7wqe2RZCHpE/m8JUiMSWyhmaNtY2wIblQEsR0wz06M/NSeNtppk95d
	 607XKsCENBUma0KWdfLn8Bc7q6DRm0U9KhOo9IcR5X2K5+Lv/mBXDqbHFRi23EXsf0AYi
	 nIkWmJSI+PRs7snyayv27q3D5uaGqBXBH64TgCT8Ztq0Jgrl67+x4BN7N8M/mXthL242Z
	 oYT9AsQwDo/p6o53B44STuw96tlzCtLPvcJGeH6J4MMVHnouJ1FMePIxq2Ik1Um/8iQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
	b=UUn1NGVUFpqQukvMJc8YaYAOWoMQ0Q9AMCvwX5t5dA3UOIQVW22nKSMTVBK3P0oFBGIG
	 wqMtzuf8XPsaAa/6/dqWEEkQO/squKKco7ST28EZ+X2W8107BPJnWEbK3Z5ILZhaHUV7V
	 KB/YNblxkfUrRsjIO8AY0BZ5KFK1HkmcMoOflKKWtQU0nXEl+PPIfFodnKNC2NU14H2Eu
	 /c07+3gs2bBvguj0r3WVawvxoQX+J91rBBY8PZ1f9pfDex3p8+YbMHF7z1Vs41YQtIZjU
	 kEbuLpGoodM+x1nRrTtqBI3UAXJVCvnN6IvL0YTlv0zOInKjid9aq0/md9FLb4hOp6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dj6Q02wh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204B6606A32C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 16:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 204B6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dj6Q02wh
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55c48582654so25481811cf.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 08:55:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795107319; cv=none;
        d=google.com; s=arc-20260327;
        b=FHKpSM+DBAE4tCwNDUAtONHJsp8YKBuvllCEgGGJ3FPxZiyyGHGwSa1UQuOiqibDA5
         yLcEeC8LnZezHzNfDCaEU9LBpribahUTdmKfpCY21Cw0xab84YmWWI/w12oeAGyhgkEH
         oTB4G6FcSaUlcBY+qxOgnHfeOlB63GA9CZ6tU30uJTaIsSGdn11k4rPfco4HsVnWgqIL
         BSg+hd2BShJkp/pt46zmf0MjRrWAHxTEisIgfi1wcltfzeZAN5dQsp5UygqAudPZ8dYK
         EwBYTvW0waey6csNrTs87xBtW/ZqQFmZG7QtOUnHzm5YVDjFxcQbSpuGdd1Coe3+XOrD
         nzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
        fh=4Z8kUo7ZQAE52QDzrWjAPPpNicBFhQXYM+Ho8XX93z0=;
        b=sJjo4vi6Tt1FMK2NmJk5T/dUaVqsCV7g3iWP7Rkp3RISgjnPiBO35tTLKT7Ij5XY03
         90kRJHcq9g0eRTiUiwDjqJq42YGLlvgOpNmHdxuphBZsm5nKtqbF2K+FXXm4uOJv2KMb
         W08TGrARSrs5MB56Lwel+yLRAKhskFuzgS7QcxG0zqz3nTNCXU6qFfQiTirmLfVE3lLx
         30EiLLmLL1GHd9AG0moQfCszZwOXavwpXszoILwezESv34emE//XV4VMS6AcObyMnIRn
         Nt1l+LM0OkPkpSICA3RFi0/nQbIT9Orrnb/Fx42Q3+A2rHtW1kG58HlnPjVGX1euw8qW
         RPRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107319; x=1795712119; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
        b=Dj6Q02whB6jrBbzwMSXDdZSXLTQx9U55nvIhh8VsfEtTdU0iyT/o5kPY7DNq+u0nYX
         LOZg0I3QLlaCJIkJvIrIbQb13qmp5ktE+mmgtpE0tt01WzUdeODyogZmCTJRrgMPVl2X
         M0D+NQ77UpNz2/SGH5KO/NylJPHiCmrW58WvbKq5CkN3aNYjSuFLd0AOvebek1seWTHg
         CCnbeIcuwLnxBUbtekh2wL9uZ4l8/89Rf1OjkSxNpQOAkm7rE8Lp9QDgOQuNqrIgklGp
         pUt1yNUQRVirdiTXvErC+NL51Am8phRLGCrwvoT5xjkoQhc6UAcJeywZPocdIxTSv1/R
         GD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107319; x=1795712119;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iriD5MXJPRwsKgyB4ypuM5BIJR6iatqq6n6kcm3cbqM=;
        b=rh5kSGKoNZqBCj+7n3giLOloKxtaNk0CN/Q+1XOLv9YBb/9wK+86B/JytXSRo64oMu
         7RPi8/l2r9/Eic2dsNywbqubn9eGCHdIx+zYmnrbmpEzcb6nkqzw/s/lz1OXWBpFl9Mm
         ijHyy7fkaheXxlsw/fwhDg0wblF2EHlq4jJXQtLY+ZspN7xLCjLmI5OrGjY62QzCtCaW
         WiOWwwrPGyJlzaSZwRjUQ/kQF00Q6qI/GvQLE31Q8rTH/FOuLaMP1467m6Zi/pH0dNr8
         tp0WWe8iyYEljqwbE50kf1Aag7HIn+txk2Lkq48hIFgnyWwBRAwCXROnfbPVgv8oOYBX
         /CQw==
X-Gm-Message-State: APuU4Z8xWc3WPMOLGybPrmRXmSkY3+/bkz5l1MZoR47YhSpF7Zp+lJdu
	Mb6mcPsX4G1H0z9sRbEuBStC+jg2dQcJDG/LZL1qV4YZVum1MQaGItS0wriGo2wzqFOT9LTDZwq
	xASOkvkSf6eMqNuhHPJzYkWb0pO8y1WI=
X-Gm-Gg: AYBFou3Y8kXa2dF72YkOqEseJx1jXdrJtyq3TO6lKWEbFtBzmsKQ2mHJvvQVV3W9XFW
	seNSX/wBY76UBGhre6eiSFGPdWlB4WakK4nyp/sGAb3FnRK3gLnPo6tDYQV8UxzE/XGx+EDXH5E
	oPo6lWf1eI9STY4TvPEB1D1l0erwMycClo/apkTSE2plJuHLbj3lHh0XHwy/RB7hpDX5xMKdFGu
	pi7S/fF/PJIhOfnAhg/2Nt/OBi6zsxvPHwePwUJbGwz8T6kG+4+xEBD8hChBBLIEiTcnZsfTmwG
	EVOwfzpRb5WV2lykF0T1jg0h+zyP3ewjLOuKLpxssu+ey5g4WjJs+UdrdO0InoQ7+j/DZYCNHFN
	UdbArbg9FiC45jCdWy7PbtoYCHQ17ZrUqpLtY2aIBfgB4Jt/gcUtXY28Zaq28EjNv1HtokspHNL
	Lsc15Q4dZSHSdoWizZEA==
X-Received: by 2002:a05:622a:2586:b0:536:5696:165e with SMTP id
 d75a77b69052e-55d7698ee3emr8706221cf.2.1795107319050; Thu, 19 Nov 2026
 08:55:19 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 11:55:07 -0500
X-Gm-Features: Aa3M54o80hka7iVgEuzkvF5iRLkH-0ir8Ksq0bm_-gLkDHL4y7vTsKz_LHD8a-E
Message-ID: <CAMcAce97zgo7c2f5Th9FguAHEL5gL87NrJ9MJkJghMm6M44g6Q@mail.gmail.com>
Subject: [PATCH 6.12.y v2] bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 49b18315be4e590fae0fc39c87d46c87e9ec903c ]

bpf_verify_pkcs7_signature() passes the return values of
__bpf_dynptr_data(data_ptr, data_len) and __bpf_dynptr_data(sig_ptr, sig_len)
directly to verify_pkcs7_signature() without checking for NULL. If an
empty/null dynptr or non-linear skb/xdp dynptr is passed, __bpf_dynptr_data()
returns NULL, leading to a NULL pointer dereference in verify_pkcs7_signature().

Check for NULL and return -EINVAL.

[ In 6.12.y, bpf_verify_pkcs7_signature() is located in
  kernel/trace/bpf_trace.c instead of kernel/bpf/helpers.c. Adapt upstream
  commit 49b18315be4e to kernel/trace/bpf_trace.c. ]

Fixes: 9b2d3e911295 ("bpf: Add bpf_verify_pkcs7_signature kfunc")
Signed-off-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v1 -> v2:
  - Fix diff formatting and line wrapping in patch body.

 kernel/trace/bpf_trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bac2db7..41e237d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1384,8 +1384,13 @@ __bpf_kfunc int
bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,

  data_len = __bpf_dynptr_size(data_ptr);
  data = __bpf_dynptr_data(data_ptr, data_len);
+ if (!data)
+ return -EINVAL;
+
  sig_len = __bpf_dynptr_size(sig_ptr);
  sig = __bpf_dynptr_data(sig_ptr, sig_len);
+ if (!sig)
+ return -EINVAL;

  return verify_pkcs7_signature(data, data_len, sig, sig_len,
       trusted_keyring->key,
-- 
2.56.1
