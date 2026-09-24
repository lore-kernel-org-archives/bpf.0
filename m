Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B338645E
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229312; cv=none; b=iU3anLAsNAqmn1PupUaWpy1zh4tO5nz5KWOAUecUghkt/j7FUF7jxBUmYG5qmLmJtiHVKDJ+UfxP2L8+U90A21UcX4RyHd7ZLmo3e/ZCFkKEF4CCBFnh1ipW81tOtgEV4q04Af0GpNu1WZoLyLOZXa+F4PhmLh9b2Q05M6QPcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229312; c=relaxed/simple;
	bh=UL+LI0h4c36cdRdGcGfWjMqurXYQO/t2weRNIAn3RlE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=ZBhopv0hK+5pIKCG45EN2FXBMfcXz6FH2htDfmQnKtQC+sUhSzVxYqIJFVb9BQmwbkbsMTLMK2Xgz6g9NC8/pBcrZnVliaZf9thrZkfxlDc2SpRIiCAvH59iBiHEzUigKxaivZ5NxKjwAyTpFclGkQlhux6J3UpzTIYm8NbhKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmIBp2KO; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmIBp2KO"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f204f6so848998b3a.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790229311; x=1790834111; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o2VRo3LgV7Xq5txWAHBjJGGhmHXUDPSnyscc5944sQM=;
        b=BmIBp2KOczXrztbyV8+Y9B3hM0tLe+n4F/XT/alfEMffwBfiW21uUlbYP2GSQSc4SP
         Pfgymi5nZvOXBqZ1ifZVU2EmQxrp6dunlYwt9rsivXvRfOLxUa4Vp27NkekayuVAbTBt
         CcBryxjnPSAs3HM5hkSJbQm2f/dRxTBbwMxURNYDAoz4hH7DFmrLSVeNf/w1ZEJlhDfy
         GQAdk5z+djSgOsDVUYc2tvpKZKKO7KNkCJVzX8fb2QJgjgURYuOOEmffEiUpQOeGvTG+
         bEY0yx2CYNorTnOjhtxwW/QL8+jFdPut6ckXSDYheMdNr9kxiwaLAFKG2Dt09cfJi/v3
         VxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790229311; x=1790834111;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o2VRo3LgV7Xq5txWAHBjJGGhmHXUDPSnyscc5944sQM=;
        b=QDgaBe4+n2MJeht+wjx2jVICqhCAUT5I7HVyKYxuKk1nZ52D0PLiwQ6gVsMMRJEN33
         mdtWk+olgLVywdHHnpVa14px3ejZ/t47iI70kEY0uNg3Dq/uKIGOvYmxxuKwY7vo7nc1
         aTbRapCddxDS/tFP6dYjVeuU6+ef72DjNzUlGFfLLwaMXQBZaXH1ywNIft8NueMcAdaH
         6f34ulfFHXCSpafcZjAOH8A+NWT+p9+QeEFORnQ32D5/xW23Vv/E3XbsoffPPnUKlGBM
         wQwSbUYWoKH7OiiKWBrOPTC78AWPmFvrYmyMERodden3Aw8SqDJ4Q5eZjgOkNQmUEzky
         mhgg==
X-Forwarded-Encrypted: i=1; AKwUvBwTBF6w2z2ADLjB8elzNZMwZzUPZQJhVmczKcnItTO7zAZca3I2WutR9+dhtS9oh9NSO+I=@vger.kernel.org
X-Gm-Message-State: AFuF++mCt32YKZ9kvqi2n0INj7EgW3Q04f835ZQg9y1dKqWHwZcQDbdG
	aLPM/V6mzvx3tN0ai/389FMSnEJTBedhQchCbQ6PqfOO13+x8biXuyNz
X-Gm-Gg: AYBFou1BSgzBRt0wLz/6IPy7vj9KGltPwIBHFUccd8U8v3fm1OOXQ446Xo62wj2XNiK
	4aoGLvFMygXzd3DyqsGY+ZMTSQvrjSq5XcSF+W4jP8ai+DcI9r/aYDfOFaCiUYx6LHQgnzuEOA4
	BwPGNIcHOITiLTXlyrQc37QG2/NVdTjdw75Mt49KRfntW6FUU4tqRgdSNjUtNzubAgFH4r4M02j
	LKtjPdrKYfXQ3gDjDQqVFy99NjjV+99ZBJ5+Jqh3iHgJ0KvAyLL5GzQUJhvTgGXD94RzdSizAcr
	9ShZqv9GMFJ0fv64F8cfNF6Ry3Q13/z8RPkxklCpvRJqLXReUGuMvjEInoX2ygZxpcV7IeCq1r5
	W/NoZabCyH8+SxgG+TtvUUZM8c5VvwwKoBSl3UJYD3pihx6402vH/L+dsUR0S9nqA+vd7qK+NeI
	mqMBM/Iwgj7TihcdlE3HDIzIWlpvivYCgATfhcsRRSvU2sOqCHpiU6opQY6yMCwmcwIFBMw041Z
	JN8pyStI8HCTCDRJR/6047HjhYu2jWIbFl6lWVb3HrcXWgkC6J7co7V9GauboM5uvqymlZg50xl
	bIM=
X-Received: by 2002:a05:6a00:b48:b0:87b:6b3:2cb7 with SMTP id d2e1a72fcca58-87e98994b24mr1148128b3a.12.1790229310546;
        Wed, 23 Sep 2026 22:55:10 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e601b5dsm2278305b3a.61.2026.09.23.22.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 22:55:10 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 05:55:09 +0000
Message-Id: <DLNBBR9198NM.1OAVB1QAY5UG8@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Check fastcall contract for helper
 and kfunc stack buffers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260923084201.2437625-2-memxor@gmail.com>
References: <20260923084201.2437625-1-memxor@gmail.com> <20260923084201.2437625-2-memxor@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 10:41 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> +	/*
> +	 * Helpers and kfuncs can access stack slots without going through the
> +	 * regular stack read/write paths, including when raw mode is disabled.
> +	 */
> +	if (access_size)
> +		check_fastcall_stack_contract(env, state, env->insn_idx, min_off);

can we do it once in check_stack_access_within_bounds() ?
Both check_mem_access() and check_stack_range_initialized() call it
first, and it already has the frame that owns the slot and min_off.
Then the other four check_fastcall_stack_contract() calls can go
and patch 2 is not needed.
