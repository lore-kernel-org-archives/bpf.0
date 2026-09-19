Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEBB323416
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828736; cv=none; b=uhpZ7IjVlfy+TNcqHDG1mTYynUxxrZjxzc4vb/wqfz8e5QWz9Lhx24HQ202/hL8vymB1KZhQU39kVNYyzX3O15Un3FW0XDD5XAyolPjzSX5D2toySh5gXGXD/mujCQoHFmDAoZ61tXDFML6o+DeCk+1R/nHDVnj49w+wEfJAgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828736; c=relaxed/simple;
	bh=CyLVBdF6HZsyd/B8ZtdVAcP2QBNL8FUqGKolgEHBUho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BiryO/kg297+nFjSlIeJ52YE6q5t0zP8Mna+mP84ppRfrPWDrUKiANozIyimtUJxdRNbJumuxQ8zOqHqhe9VKw/b3zdv3p1Jbk/TYfMHjrbz4WRxOCV3F5Cng9HpPhsJ9CB/3Ajprn+hni5mg4JmzN/QHkuPr5NvrRlIvk6Hyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy1ds6Ve; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy1ds6Ve"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ec6188so10365065ad.3
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828734; x=1790433534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hsFrPyRZipOaZhEq/8OQA/iN9lQPDPtm3xyWhXDtLjQ=;
        b=Hy1ds6VeT6CEiGHKFJ0bKuU+98QVBAYZde/dp4cFuRK0D4Segv8bvU/Tdr813U4jRb
         Lp2C7YCERv8Rh7L+JzLMZnniACvyTKZ1NztBlFZRdaHY3tjza4TGnOZTADy7WDnv5Ivc
         lP66tW22/pd1tMTEzaJW3L+4I8d+7HlM5QO4r5BZ26569XlVNjlLrTmMFdDMdBqsttii
         RGf6gCEnw97oKFOOOOMdxzedYIO9A5XnIhFkW4j3w+Vu+KJaiLdsLd51OaHFkj23d+To
         njmG3vN1daPdSj8v2eGlb0I/RnD1dcfOyuVRCQx122IWc4ggT+IFu7GMi8Yez+VR7A7C
         xlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828734; x=1790433534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hsFrPyRZipOaZhEq/8OQA/iN9lQPDPtm3xyWhXDtLjQ=;
        b=ZeybIsN0OFx6xyabHkQ0f3sLYPeemODCUMmp8ovDZzHK0S0c6rwzmm8E8LGQ8RcXk9
         UI8Kfj0CzJ58308PW7whIX795RnaZThNaOzlLXz0nKgF0Bc/0nsvQnPCSAHU+QrFgrQD
         uC3yBt91fkdlTgCbUir87cy9x6M/mNJBB4cscqRBkecGQ6o84tTC08MwCXvioA9M2YRn
         R2dxE1xOFOQVKPX/2Cu9jOLkhuV58DvNvB3YhxaBd/p/uLivt3hQDr/gFzDWzulyc8ip
         IKO2iEs33r08tAjpMoA63xaHxSIXn2FZDiQulMOKOudMRduolBrRjzS75XqOtganBzFi
         HOPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSWE6V57FUe8Qb0dfzQ8jt4gOxxR/SrpNtApvOMQGDBbkm1e4Qrv4bPA8o30dP0nC7bbY=@vger.kernel.org
X-Gm-Message-State: AFuF++k/LAU+yadiQK9cltPjNEz/10vWnvOrgh7RMVafdtT0XHj1f2sy
	6J1id34Hz0Ta4x3aN9KtIEUCkn1kF1FwGGXQ0fw5u8pAqeaPcv9MqRdy
X-Gm-Gg: AYBFou09VWZT2Vz/5kB/QK0GO+8bt27c01QGIMZ3Hq2Z9JhsmlY7KRh7rmwiDggI+Of
	4k68kQmmNv880d8RJ8H/GTIXirulpP6XOj4BCynry9SClEM8f5TyAKRP3uncQB5LrgQORkHJyMm
	WhvzlP67OrbslCUSgnJcZdG2KhPIIRtBGJ9Yeqx+Zy3rcrtRFE1YkjwEnEwzg1uJsSWnkNxo0JC
	sr2ifJf0Fhhc1trJQjmjobmLuYyaUJWildVpXwElyDL7vFLgENPxPgTRjG4zLBeC9rB5iiBOW8a
	caO/N8vSWXnca3YyI/6RLcHZjGCkOVmDSmxQMqAMwS3ZEd7O+LXh6H00uV6VfZCY+mBM8ZaKob+
	zqEw029gOnfJGLqk1MnvGinY5CV0z3DEVvYcvW7HvrD5pawzLTOyLh2swKABrbA66XB1daWDeTL
	yt55EvgJ6K3x1ZKgCasI+i/uCLQ1a/kj1ig+C5lEoX3O7vCvGScNGP2w/b6RLxUQGLjYh8te5zD
	KU1AM78/hX/vQ84t/bwnG4w86j6ZEggno1eJkPHstO6sPRSKmFsFfdI04Q8zM7NhF969KJuPw5p
	5XpXkKh2gGUhs66eRuUE6p0K/T0V+tIekfPv6HP4MNewFOS17CSllQa+oTM=
X-Received: by 2002:a17:903:4b0d:b0:2dd:c100:424c with SMTP id d9443c01a7336-2ddc100456amr36507175ad.48.1789828734264;
        Sat, 19 Sep 2026 07:38:54 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:38:53 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RFC net-next 2/9] bpf: add bpf_ktime_get_real_ns() kfunc
Date: Sat, 19 Sep 2026 22:37:25 +0800
Message-Id: <20260919143732.11772-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new BPF kfunc bpf_ktime_get_real_ns() that returns the
current CLOCK_REALTIME time. This allows BPF programs to perform
accurate delay calculations without clock domain mismatch issue.

Previously BPF programs only had access to monotonic, boot and
TAI clocks (bpf_ktime_get_ns/boot_ns/tai_ns), none of which can be
subtracted from a realtime start time.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
https://lore.kernel.org/all/20260518082344.96647-2-kerneljasonxing@gmail.com/
---
 kernel/bpf/helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..7a0db620a273 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2335,6 +2335,11 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 
 __bpf_kfunc_start_defs();
 
+__bpf_kfunc u64 bpf_ktime_get_real_ns(void)
+{
+	return ktime_to_ns(ktime_get_real());
+}
+
 /**
  * bpf_obj_new() - allocate an object described by program BTF
  * @local_type_id__k: type ID in program BTF
@@ -4972,6 +4977,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
+BTF_ID_FLAGS(func, bpf_ktime_get_real_ns)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.43.7

