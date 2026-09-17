Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BEE5592F7
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656319; cv=none; b=Ha+5Qz68aZQUlbJOnSF85VNZUEZjkNLx+lfWhwAZ420bvcrpHB1O4GGkX4EgBdw2YDWNLfNryb2c4I55kO/pG5j6qa/O+o4rRkwpLTBsS6HL3qsBUpBSdEElIqwpebd5NnZs/j0xreeLIi3lAFk3n9KKa1ct6BOHNmtiN37SK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656319; c=relaxed/simple;
	bh=/Kseamzw+FiHOlMC6tinkyAlkcVgzf3JRSCasWxHCGs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=f2tRa6kcFB9+GBVrXB9Pakjazxqe6gGyet3985SneCMfQzKyhImBcGHJ4vSYhRMmpMKEMnnUshKyO4+0p23l4PjECa3HmoZN88yedpqCsafSsAIowxCt+Y5wdDSL9jWYK0CDovAF/lfrVxUIookXh2IGDelxOl00HxuGFUOmy8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK3Pe6Pw; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK3Pe6Pw"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c294496989aso145633966b.3
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789656306; x=1790261106; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s0KFjZaiCcsYCFsD7bD0Sdl1dteweTOt1UWHQvVWxYw=;
        b=QK3Pe6PwKd1/JlO457Y4TJW1l3lbjUuEAZRDURuc7YDHEwgJ/is1z0SA2f78hE1N+s
         /1JmixgcUtJACT5UFJzqQuR3ow+hnLl9PuPlguPteRua+02LkwCtevaJwjD/1TjozCjK
         UQgtXmEvLA2RIslioePb75o5N75RCpebhdXHCv6pCFoYrWDIjxMjZe0kxN/ydQ1oSznm
         qPrra2UfdKJTLBqQQCFhjenx6xTSsCfbuO3RQ+usJFD57i0Up4v/5ZLlGuDsAnjVLfXV
         vJ01agpzh9fjSe2Kgx0F/kw5JGCKLZGaQt6ZYP0mGy/bHeL8GqsHt28TXHLQmOTHykfE
         G+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789656306; x=1790261106;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0KFjZaiCcsYCFsD7bD0Sdl1dteweTOt1UWHQvVWxYw=;
        b=IQfIRQQBSkTNzfwlvm/7viUtT3OL6Lp4ZoHpX9pLiGPGJcrv09IMeRA+XjHIfOR1o2
         XmGxtF7FL8/DDf20hD6U1AB8k42AgLlHVLrP3qzM2Qhmai7C6Q62p0FmWT7ZYms4fbkF
         c4kb/o7bSI40XMXSrfuc5mBeSaz4xfQ2y1Z8xn73J+cUV/XiaAmhq2BZ9+HJS0t/5dsE
         851wZ+gTWK+fXLUkcDV+NogGgM+j2IysWArbHvBZ9hBO1a8SkZjsw9XuH2ULtHd/CLSW
         FpTTa504kvRFt+bN0XTofWm/GK/GR5HkspetWDB9XvTBY/X0+Z6dRhJ9Ofn7fQFZTkdn
         0JdA==
X-Forwarded-Encrypted: i=1; AKwUvBzkbbK2WuuVrXiRzsD1c9SdHUPI63r054iBIEz6Qg6eB+V2mV18s3JVSqQ/p8y0TA+FPao=@vger.kernel.org
X-Gm-Message-State: AFuF++kfMSoyMwBjuJ8EdBBri4fNhzRHBfeDjjAYflHGBo/KiMTD6bVS
	wAPNbZZf4t+YF/eq24hcMBpKUMRPt63xXcaDWVzSnkH9Oy/B0kECTm29
X-Gm-Gg: AYBFou0/htUh8QqheM8QE/d6AKf8fvDFAcOgkqIjc1uaxXtPZTHLnckhnuT3utzWjOY
	Go4hIYtrGx9w/eyE92Zeephx+cL9qvTmZFNrKQsdEWtY1JkbY7L8i+lChQOh+ejF9xdr4+JDfNK
	bjiYPWbGp/jR0Nz2sXcpPfl8mi58LA08guOluOkDXdphMNB+XihDsRow0ooMGYuSNYBcrhuZNSs
	maFCdaQqYXD41PFif4k1Fl87cbYPNrJZlQiDQIYLxp8FUMoKQqS2FBGQfmMXJAlYFrJdpHuUcIk
	FNgL+jDGlspg0sHoCWthFAZrULiV/9DexkC9mF6YRnS1QCuzuZypJr+msa6M9X+JyjTbcAs4Fh+
	EpB8fQpaGUEo6o6c9gceKW9xh1lGKVsIhWKFhUHx1a+aEWzjWTnDgJ1n8AH7yQ1z3zy4WYRxK1Z
	TAKJaadJmeAPdkSBdb+tatADofxxHe39rUzbQ4GbiNWJq2mYg6ZY4AWQwKLlWC0ruZEYrFZtYir
	+FFGjFCKwKHqWMJ/gcw1BPbS3TuDRSzYe0HchvUDrfiPicpfaLiqKLNe5FBmBPlYPAqiocO7rZO
	YvcDwenp4bmUxjc=
X-Received: by 2002:a17:907:7287:b0:c26:1648:a069 with SMTP id a640c23a62f3a-c29e530862bmr489369266b.36.1789656306018;
        Thu, 17 Sep 2026 07:45:06 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de5bb4acsm291810266b.41.2026.09.17.07.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 07:45:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 14:45:02 +0000
Message-Id: <DLHO7NCJVWJV.1K8VWK8LFIKGD@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <ameryhung@gmail.com>, <yonghong.song@linux.dev>,
 <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Track iterator-owned BTF pointer
 lifetimes
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>, <bpf@vger.kernel.org>
In-Reply-To: <20260917051948.1588826-2-xyx2021@mail.ustc.edu.cn>
References: <20260917051948.1588826-1-xyx2021@mail.ustc.edu.cn> <20260917051948.1588826-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 17, 2026 at 01:19 PM Xu Yunxiang <xyx2021@mail.ustc.edu.cn> wrote:

> @@ -6219,9 +6231,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>  	}
>
>  	if (atype == BPF_READ && value_regno >= 0) {
> +		u32 parent_id = reg_lifetime_id(env, reg);
> +
>  		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
>  		if (ret < 0)
>  			return ret;
> +		if ((regs[value_regno].type & PTR_TRUSTED) &&
> +		    !(regs[value_regno].type & (MEM_RCU | MEM_PERCPU | MEM_USER)))
> +			regs[value_regno].parent_id = parent_id;
>  	}

Any trusted field walked from a
referenced pointer now dies with that reference, e.g.

  file = bpf_get_task_exe_file(task);
  inode = file->f_inode;
  bpf_put_file(file);
  ... inode->i_ino ...

loads today and is rejected after this patch, since
release_reference() on bpf_put_file() invalidates every reg with
parent_id == file's ref id. That's the right thing to do in file case
and vma iter case
, but likely not the case for many other iters.

We need either opt-in or opt-out. Not sure which is better.
Certainly some flag.
Blank reject for all is probably overkill that might break valid progs.

pw-bot: cr
