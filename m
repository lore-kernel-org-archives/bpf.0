Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722032FA2C
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891442; cv=none; b=ko6JmyJKSjRD7Hlp8uNeF8mzlDtcPkHzJ/Dv/+Sg//DlhWH9NLq+pUFgmD17wg0MaBaRye1qLLYtIZicA5ZkS0ucMteFgEb5Yod4boZjQL7fRr2HFXk5ZdQNClLmkgURCiTWZr/w+xnqy6ue0axEFBg0kfOltcrCOpBrTsZd3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891442; c=relaxed/simple;
	bh=GqkBkA0ux+YD7JioYqk+V1T0qYPcj0feX93g4HGLcqs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hanNl0yABCcLErhwxVhASxqP/X/h3fdizAyszWifwpcEn9dWA5+rPuSw0OYBoB3KSvwETKJcQaFxW1U0OmTNey9wb16UQRdHcl93Fsl8bPfTMWKxg/BxqmJzYv3X8jul19t7AOqZDh/zgloXWD3S6SoLfD/I1sFzzlaX2Bzg+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjSpN2H1; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjSpN2H1"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7de4be15125so11285453a34.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779891440; x=1780496240; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jshKEkryiFgJPhBjTFxZ1Zd5Ycopkm0kpYznZELan4=;
        b=VjSpN2H1vYnAC0Pgzom7GVsB3XVz28KFpb9juBqVY8H8SMiy9Og3a1KX0BtN4fvugK
         C+BYhlkR1N4YghXdNTSSv4vBd3vVhc135+FDmthcczhfNSvsvymCWzqwkwSmpgBl8t51
         UT+9lluGRrBGVJvHBXgHWlCeOyxoSvJsPnOuw7Bi8Sp2Sxm/d3k4rV2GpeGFGaH/YdvO
         XKOniFD7vJcsjqf8y4sgz0BSswAMeDa6148D7qlqFnK3qGr32k2bn/XtQKTru5JIHWUJ
         gJIGCyS713JO3zjaoJFg7s8h3VA5QKRgiH9mUPrG/eZGzFpWISOm8Ns5xZiuZ1ERhnLm
         odTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779891440; x=1780496240;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jshKEkryiFgJPhBjTFxZ1Zd5Ycopkm0kpYznZELan4=;
        b=Yr9KjpZdcmpKmPsd1ybpxqsvgjUQ6Ijlil8bPOkG+ZO/MYlMGrRRJ6Jqg0CQBQcCwF
         lD2tozR/uykEvcyF1cp47s7KgYqRRDRS7yLNh0+468dNArkjNp+nGO95o7CZIrzu37sV
         1MZ6O81d2uDo6a7EujdKLL+9tEXlzLhEudj/vxVoynW7fE8XWlk6rEsGLz7mZC2LUQOT
         31xcA15+blKudv4Xw6nAiDbmHpT/SP9NXil9wLVkCMTychKYIjXIaO46n01802gNF9D3
         SS6O/V+1HpUvStDr6ftyeK4kVK8pLPc0v8YPM1Q6+/QM5Jq3QY7pWxobnDekAig5o+vf
         pR8w==
X-Gm-Message-State: AOJu0YxoJEjJaxYT0lT2IEPk8w9zks/7VDXy8hBTfBCiEC2bW+dsORXM
	2MLy5+AAP+lTLiAa3mi2xJQ7/cwwemBCX/n9MH0o/Wf4reZoufrJXDzB
X-Gm-Gg: Acq92OHHyhXuEeaCYwvvadjFRQUZmc08bWj0GkMrJh+qghJ+JcyI3LYT+6LtrRfLskF
	TIN4qGmWYlgnpLtAHPR2IewEYtAmELzcixvwW7joDIgsJiYvf5bsvRg3rXrzCsGjCDUsNEBmfls
	lsGzv2/PAE8tR7CB65CCDb243DhT3/4JeqdXbSGm6EpYrkwrct6fRc5KCVJVQitEUyBiknqwRr3
	z1FO5jfP/Gp3fpXQ37QX/ik4Jn/LLr8Wx5xeMGpjkhA3vqwiRXET/di51aqVzqA0UUPglve9Sli
	g7LSachX5rtmqDqRyz/MD10zw7l/vioKwqbsLl3v4GE7BMLxlDIYktAskRmJcjwv848ru2q6VDw
	76PXYqSpXyxZyWhsUWE3cTfmjZsgwep0iXfrSYr739l5xlQAqYWwlbt5d45zcqixZ9v7oxc/8mi
	AG+WZ5nL2H30a/Pu8bEvCl9MGz7XTV4nBXT0X1KDzlO17S0YxuhkHvMsHfpB14Ul+EoG79Rrn9w
	YvsJ5UsICNDJyK9Tg==
X-Received: by 2002:a05:6830:61c6:b0:7d7:f146:8738 with SMTP id 46e09a7af769-7e5fee5ec6cmr15466189a34.12.1779891439617;
        Wed, 27 May 2026 07:17:19 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e60667af4csm11732221a34.27.2026.05.27.07.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 07:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 07:17:17 -0700
Message-Id: <DITIUUJ1PNU5.26Z6XGZ2GQG2R@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <gprocida@google.com>, <maennich@google.com>, <martin.lau@kernel.org>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH v4 1/3] libbpf: load vmlinux BTF in gen_loader mode for
 struct_ops
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <sidnayyar@google.com>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@linux.dev>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>
X-Mailer: aerc
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-1-27daa15487a9@google.com> <556048bab0cc9bda9a7dfe2d041308d35eed943c9295aeabd69d34414e2a9f4c@mail.kernel.org>
In-Reply-To: <556048bab0cc9bda9a7dfe2d041308d35eed943c9295aeabd69d34414e2a9f4c@mail.kernel.org>

On Wed May 27, 2026 at 6:39 AM PDT, bot+bpf-ci wrote:
>> commit 29cedaf6d7d80a7e880a2e639f40fbafcbaf2e65
>> Author: Siddharth Nayyar <sidnayyar@google.com>
>> Date:   Wed May 27 12:52:57 2026 +0000
>>
>>     libbpf: load vmlinux BTF in gen_loader mode for struct_ops
>>
>>     During light skeleton generation (`bpftool gen skeleton -L`), libbpf
>>     runs in gen_loader mode. Previously, `bpf_object__load_vmlinux_btf()=
`
>>     completely bypassed loading the kernel vmlinux BTF (`obj->btf_vmlinu=
x`)
>>     if `gen_loader` was active.
>>
>>     However, BPF `struct_ops` maps (such as `sched_ext_ops` maps) requir=
e
>>     resolving the kernel-side struct type IDs and member sizes at
>>     compile/skeleton generation time. Without loading `btf_vmlinux`, lib=
bpf
>>     cannot query the kernel BTF types, causing light skeleton generation=
 for
>>     `struct_ops` to fail or omit crucial type information.
>>
>>     Fix this by modifying the check to load `btf_vmlinux` even in
>>     `gen_loader` mode if the BPF object contains `struct_ops` maps.
>>
>>     Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
>
> Alexei Starovoitov requested in v3 review that a selftest be added to
> prove struct_ops light skeletons work end-to-end:
>
>   "The selftest is mandatory to prove that."
>   https://lore.kernel.org/bpf/CAADnVQ+AA_fmRw7uRwdL2TMyMbpWeebOQKb=3D0wvp=
KiQR6Ee5xQ@mail.gmail.com/
>
> This requirement has not been addressed in v4. Should a selftest be added
> to demonstrate that struct_ops light skeletons work correctly with this
> change?

thanks bot.

pw-bot: cr
