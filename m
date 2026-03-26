Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430353BC67B
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518727; cv=pass; b=HFxJr5fEC0vGj9RVs4ZJRcmkDXlG8h7xX0BtdmvEDcIJ8ymCvdGy8hUeL62Xay0IVHjVJ3pRdq3yyuOsuelC730PVrP9QPAto1y1xkqdTatWQg+y51/Y2GjY0+P8k0ry80/ECHiZRdXxgIBTabv7cdG/eG5dpJ/Htc55dZMfGeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518727; c=relaxed/simple;
	bh=HP3i71IBW3dzk5+LEKvOb4AtDvAhUXrX9gvCaKKRN+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lcw5Ec7dNqOZ7HAElqNYRBr+Faw5UyjmFnUJMxyimL4m70la/lOKplpCIHSEBHvW6Ghezi15xGliXWiOHqpoz4p4/QGd+A3WdIeHF3inxKSMqquaLc8jAv770dOfYT445HFy8vcKHKMDZht97ehibupniJI/OVNNG3UCthXWM4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR8JlhNJ; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR8JlhNJ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b97a9f4b4dcso88728866b.3
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 02:52:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774518722; cv=none;
        d=google.com; s=arc-20240605;
        b=kWj/4ieDygHseiTSPddvUogdi5n4dXHHD07AiDdVXz8+Qqn2JCUIwuXL8DOZvVXbaz
         mXkdbw8PMflRnH6hhgTsooYxlYvo3rg8O3zRJ5nIuvNWgBW7LM0fO+3tN6fqP8s4J4KW
         f19s9Z2tOCIRw+VUDP0cYfkEJkvueCSzHt0peKtViKYDe2TA99kyZjMbLqhYj/ivvizT
         pzEKSgMeEQM0fp922ly2XrDR6EaeMpP3yu3VYUUu+EpfkTWopcNacHSc0AevhyyVgRBU
         6XS+buiyw6gGXd+3Qm+MZXvjJXNwmOh9bjxsfbNh8kQWxFmI6CdgJJsOB9y7Vj7Ro3gn
         c1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HP3i71IBW3dzk5+LEKvOb4AtDvAhUXrX9gvCaKKRN+w=;
        fh=kgRp5VWqnb+R1VaC6eqio3iVft5+kpalc+14mahCSvE=;
        b=QR7BkTh8D9lxFlldNY6c+yDUUgPO2aRjBeeZvQcM9yKEAkb/CJjA8keEwm0DLce/Ae
         sb+kt3SsmraWNwT44t9bUViBGPobkkIGZ4Akk4EMsOrmeNI0bMCsXMC7mtx5EYOfIfW3
         z7mTZG1RCo1OEuWqJb2VYRIO2CZ0BcXtLadHyoHc82RI3FBTErlId1kUx1X4s4Bx8JTA
         1pTh1ayvMF9z3ZZpuI/9F6p6ScvY06E/b67aJnICNcofRdQrlyEuBkh+kd1AY1WnXwbK
         Lg6IQMFUDXRZTWk5yfFX8aTW0bAuXnk3KjRXFJ+0gGWOv2C6KZxs5MOgyXovGwZuMC9h
         xX2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774518722; x=1775123522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP3i71IBW3dzk5+LEKvOb4AtDvAhUXrX9gvCaKKRN+w=;
        b=OR8JlhNJulYkCyBRGyCCbB2BGGB2rZoAZq5RfpeKJpJtrS/eCrkUM3u7R8rPR+FEsN
         LxGmmzAecRYoyKGsJlK+G55ZMBL5odhuxu0OKkwQV2f9b67LdPKv5eJS0wmGT2V8mX8D
         zjJIFSQbYa1NvtZ4splWB6FHmNQ38H84GuYhS2d6w+eenZpiZdCLFqWB4hO9cN++X543
         4aPWdgdL96mVzQ9OBNLAx35fPxBEnKOYp1KQZ9xV8AvT7u2Hecs28blscoYYAYsyf5PY
         o03o4NPP4RBuzDqFZ4IrrhwBdcrNKaDI+sJr8zG+DTILB66VdPzJ8IiGehAY4cGWTXv7
         b1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774518722; x=1775123522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HP3i71IBW3dzk5+LEKvOb4AtDvAhUXrX9gvCaKKRN+w=;
        b=NfwJrX5LJus7CGGAHL8qYa9GzSVGAo7Z7feFlEd9Ij3d2mxpHGj7nng5zhkHLJw14j
         BMmGE7R1zBvqvu5wb3iXhtm5WFMHLUlyDE1Of9lAgUsr/7ohvIXTH0dFepLh8Guk5pvs
         0CLBzXe588fwmp/4MHvpsFVl65QRoTKqwus4kmrUPGUxcARmqfIeJwV7ADHerGEpvAW9
         611H58Q+1k3f1XNwOMzSSL21IhpV7hrjAh6ZpYkvL6mYF3HYEVJuFiHTXiWMNQ4ro7/z
         Mr6dj+AEh85yNUtvNup3/hLwWlZhKlB/EzoeRZhTOdocfqcPeMHM40NcxjEbKXH3I2+T
         V1Fw==
X-Gm-Message-State: AOJu0YyIyjJJPfppKywjARdwSXIEULQgZpsVG3GLDNK0I3jxIcBS0tQk
	INkIN+UuMT9gbcZdrjp1ZG/pHi3timS3S5/4DRJ/YZ9eFauNFnWT8ye7vMSHtJsJT12lpFVFVhw
	9kK3HQxa4G8wwt9C/+th/LGI0IK3THQE=
X-Gm-Gg: ATEYQzxu4IHd9Ng1I5mcpllwWzh44uzStF2H+v8x14q7+9Y6CxAb7oMwYiBS6QU0ZWz
	KXAOq9MlMe5cfev5ExMP9avJcvpu8AwyfM6V0mDDbxp1H8iCvqYKccLUPA+EIeKG3977RO15qCp
	qN45Tz3yGhkGGW6RgtvHtW48qz1YZzDSG6LC8K9mV0RbKgnicrg8uBSzviZX78CroczQxsg5HRV
	9KY49uIek8T5lMYwOaC9cVuza5WRJ/axaLqr7K0DKoMrZfLXy6VhQxROxneIyWtzI1dTWEsxdq7
	0KjSSKuZEu4OE5D8aSQyYj0=
X-Received: by 2002:a17:907:7b8f:b0:b98:4c5f:6603 with SMTP id
 a640c23a62f3a-b9a3f17dae0mr444757166b.18.1774518721927; Thu, 26 Mar 2026
 02:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-4-tangyazhou@zju.edu.cn> <CANk7y0iuC=4aD+zzJujWrwdref0zA+ZOt4Uqst_bOM+7Kqweug@mail.gmail.com>
 <CANk7y0gKbC22yrsBec_6JmyLSN76eTshcX2_W_zhSYSgXkenxQ@mail.gmail.com> <afaa5cb2-57d4-4fc8-849e-34db300f34a3@zju.edu.cn>
In-Reply-To: <afaa5cb2-57d4-4fc8-849e-34db300f34a3@zju.edu.cn>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 26 Mar 2026 09:51:50 +0000
X-Gm-Features: AQROBzBo9j-7logVRgRoJr-YlHA91LHiaD-9dsjqqUEb0kKZ6I_hqxtXFqX3Cwk
Message-ID: <CANk7y0jjLH_hYm4Ga9WAs03-QicbVPxqPWJQFRvqSVud_5We1A@mail.gmail.com>
Subject: Re: [PATCH bpf v5 3/3] bpf: Fix incorrect subprog ID in dumped
 bpf_pseudo_call instructions
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 9:27=E2=80=AFAM Yazhou Tang <tangyazhou@zju.edu.cn>=
 wrote:
>
> Hi Puranjay,
>
> Thanks for the review and the tags!
>
> Sorry for missing you on the CC list for the rest of the series=E2=80=94I
> thought git send-email would do it automatically. I will double-check
> the CC list and wait 3-4 days between versions next time.
>
> By the way, I left a question for you in v3 about the insn->off
> truncation warning.
> If you have a moment, you can find it here:
> https://lore.kernel.org/bpf/20260323122254.98540-4-tangyazhou@zju.edu.cn/

If I understand correctly, truncated insn->off will only be used for
dumping the program assembly and will not affect the program at
runtime. My suggestion would also be to keep the comment but not add a
WARN() as it is unnecessary log spam.

Thanks,
Puranjay
