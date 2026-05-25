Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0937418A
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734636; cv=none; b=l6q/wnpcXR2TtVJS2XVdGe71yTTmUT/raPQGWiHexpvEvEjMRNFXCfneAtvwfyG5Oq5EPl0ZSsmIux0bdo3oNaIOs0t4r96O50DlVruDBtKdGqmRf+eJxfY/4p2bgLgSZH9DFM3HE305tAt9HlnPS5eks/romZVwXa9WStuu+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734636; c=relaxed/simple;
	bh=CmOsHB+Uhl8sdbsASRmJ9jCtM9XOokFcRY6XkIyBLoA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Oidubj95h9Wc0NoB9/aFZ9Dch/p7uy/87Vd6j/mbGx7AjkXUXBEyPNxWkbqLgnnuM+awNttYZar/NeSIr7mE3/IbeIMi94lZ7tPrKsfX8FIKYSeOVrEYcMC/l6xosp0yXgWuAxj9XxEsLIsslKCByl6EE36zWODEF+lzCvTikhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=a4aTIHj8; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="a4aTIHj8"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1329fc4bf77so7701563c88.1
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779734634; x=1780339434; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/y1qPVvuavN8CW2BepK2QlkOZVNFSQ8VUsqMX7hC/M=;
        b=a4aTIHj8SFFLp7pb21cHxs3Ob3TIihbRQ7eAc8OPM7fTZHRBFpnftxAIMG8v51iexe
         QYWZ3hAP964W7fPiG/S0oSL8fZdNpaHt0FOjbX1gvgzvMdbDoMaUwsBazAbBkTIqCkz5
         OhLpL8zN1Iygw9O6EbQlVXD0FPBYhinThPNMHMqZNMovIlHnyBXqLZ+AXGJtCNXR2ddL
         55OD2syFWE9JZqaNwT6RnBCXIjJOpPkEBN/9HHdJffUQIeHCJADQfftGhTWgmHh6zp5V
         Y6ETRP3lEvZRRby2lZ5m6Low40fdM+yTx2nFxkuJdpiwSSxddgN3qEkAWYojTO6Mky4b
         iCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734634; x=1780339434;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/y1qPVvuavN8CW2BepK2QlkOZVNFSQ8VUsqMX7hC/M=;
        b=QC5l7hO2hV8pljplKIyBzprbpHJYzHpjIsvN/w7WGpdIzI/8REQCtkHg0PbmgbKIKh
         1ajgi3m5w735/URJgrP1D1+XrK+egLsibSQRFh7uERWrMUSHmpmU7puu83OCNeG3GSTq
         X/OCahLANTd/0fdD/U3ggK4z+JHD0Z//VJMV5UNLcXOWo5oQxQRdaHKFOUUXIECJYRCj
         k5oGmUr9v+XUwj8d25iphnhJa5H/5GMRgkQy1GdcN0Xq6LkJ2y+DsEL5H0QIqjB7QzkI
         lcS/D05/p3KCQEHggwG+U16OXqVjRnkSma8IhEEMSCHENBKCmB/ZvOhfxIHq79pOz+Mg
         VRWg==
X-Forwarded-Encrypted: i=1; AFNElJ+x1c0SvkH1IyTm1/uCj8im1wQKntgq19ap2X3/u5OshhX/7t3bqPuxkLXOQ3c1lTb2y8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyguXSrwrCFFj6QIlBtf9zXY89Xzj/baA8kYu8yAkQNPcwhdoY7
	SuHraFB9fIFl1z8ziFZHrNbWovMiex/iS/RlDpW0KDxH/nSMQiW9a7tYR9X5ycPrDvMSVDUSmOu
	iyNqWa5fTGE6q
X-Gm-Gg: Acq92OH1EbG4Vy+c1HAlEkU1Ah50j5jiMf9/QFeV6+jFl5Zhm+68ttkAZRs82CDqtUl
	2cj5cEVAKrpFwaREVe5t4GNGa/5ShbRXw0LPjt6DAXrXV+/1IXwuXmaEAMBA6ggyOKxFAU95XrL
	2bER3tezBj9/O1ZHSykzBsTzqZkEgwTFRPrAf92AJ6FuELA9qtuu/+3awNiQHg3BXsol4HmoGg5
	IiViP1yLCm1x9bDFOk5mtM8Zee47CKXlVTa5wr6KaNBJ1mSC8cH5is4bzCKUpxjLuZrGVAYnDPY
	I2+3piouCvBuYazR+IGQxNIvwQZE2igVRiEfboWLqaTiGBebFlqfFUAExYBgdRW7hK+p6vr1M2G
	U3XYfqIGYVImnefeJmH6yN8We3Lofg2ExJmies5AU17NaQdSLL++cONrnAw/crus/RF0eu216ai
	/JW9+LFvr9UliVB6Y=
X-Received: by 2002:a05:7022:258a:b0:12d:de3e:cc00 with SMTP id a92af1059eb24-1365fd7ad0fmr5429546c88.39.1779734634050;
        Mon, 25 May 2026 11:43:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::ef08])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a2e672asm8165970c88.3.2026.05.25.11.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 11:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 14:43:51 -0400
Message-Id: <DIRZ9UKO3BLX.3ARMDFHZ5CQIA@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Stanislav Fomichev" <sdf@fomichev.me>, "Matt
 Bobrowski" <mattbobrowski@google.com>, "Quan Sun"
 <2022090917019@std.uestc.edu.cn>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add return value tests for lsm
 cgroup
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260523085806.417723-1-xukuohai@huaweicloud.com>
 <20260523085806.417723-3-xukuohai@huaweicloud.com>
In-Reply-To: <20260523085806.417723-3-xukuohai@huaweicloud.com>

On Sat May 23, 2026 at 4:58 AM EDT, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Add tests to check return values set by bpf_set_retval() helper for lsm
> cgroup programs.

After fixing the task_struct arg feel free to add:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Nit: The test messages are kinda obscure, could you replace -4095~0 with "v=
alid errno or
success" or something similar? E.g., test1/2/3/4 could be described as
"success"/"valid errno"/"invalid errno"/invalid value" instead of numbers.

>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  .../selftests/bpf/progs/verifier_lsm.c        | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/tes=
ting/selftests/bpf/progs/verifier_lsm.c
> index 38e8e9176862..2072671ed643 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
> @@ -188,4 +188,49 @@ int BPF_PROG(null_check, struct file *file)
>  	return 0;
>  }
> =20
> +SEC("lsm_cgroup/socket_create")
> +__description("lsm_cgroup with -4095~0 retval test 1")
> +__success
> +int BPF_PROG(lsm_cgroup_set_retval_zero_valid, struct task_struct *task)
> +{
> +	bpf_set_retval(0);
> +	return 0;
> +}
> +
> +SEC("lsm_cgroup/socket_create")
> +__description("lsm_cgroup with -4095~0 retval test 2")
> +__success
> +int BPF_PROG(lsm_cgroup_set_retval_negative_valid, struct task_struct *t=
ask)
> +{
> +	bpf_set_retval(-12);
> +	return 0;
> +}
> +
> +SEC("lsm_cgroup/socket_create")
> +__description("lsm_cgroup with -4095~0 retval test 3")
> +__failure __msg("should have been in [-4095, 0]")
> +int BPF_PROG(lsm_cgroup_set_retval_negative_invalid, struct task_struct =
*task)
> +{
> +	bpf_set_retval(-4096);
> +	return 0;
> +}
> +
> +SEC("lsm_cgroup/socket_create")
> +__description("lsm_cgroup with -4095~0 retval test 4")
> +__failure __msg("should have been in [-4095, 0]")
> +int BPF_PROG(lsm_cgroup_set_retval_positive_invalid, struct task_struct =
*task)
> +{
> +	bpf_set_retval(1);
> +	return 0;
> +}
> +
> +SEC("lsm_cgroup/file_release")
> +__description("lsm_cgroup bpf_set_retval on void hook test")
> +__failure __msg("BPF_LSM_CGROUP that attach to void LSM hooks can't modi=
fy return value")
> +int BPF_PROG(lsm_cgroup_set_retval_for_void_hook, struct file *file)
> +{
> +	bpf_set_retval(0);
> +	return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

