Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E293D3CE8
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298949; cv=none; b=QwJDQBrQrLpJmWXnsGZSIXyfUQRxmZHd2D286n3tZN9DHXjbe3UE1lXOzwp4RMB4fGzVOqCwCHQMJU1WwGKIfcc542qDjQBKxyHsEiA0azDd1vEt+lDg1zVDzx9xFI4XoqW04NegIotNXPNAq+B8p/v5zNg56Gxw9dlhDhbmFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298949; c=relaxed/simple;
	bh=AKomfDPGXpqPCQ5CKDU6O4ox+LxcKRxoxSDb9aZYcdI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3JGsT0/Th2TBvad95uNZgFq9WuKTunN48292yKQEPrGbGN1aRTbS5f5ASHaIAXQ7KcmvKPZPt2aNCd9rRPXhtWVz0r6miEVgqgN+UXt1bUmwag19/WM5lh/CRZr0oCRsaCo6qszkNBoxDslXu5VkZXa4yvlqeLICntXbdNabgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgO0ezlN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgO0ezlN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso110108095e9.2
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777298947; x=1777903747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NsTJtYOaggrB9DsolhFtis+hmXinR1HaOkGeiY6ow4=;
        b=RgO0ezlNyv5S/w9Xj/VftiWOr6tFkQ5We3UZgIqJA/pRC9YMPDR8K/61Gmv9tSUwkm
         c3B1Pj0EMswvTLWiJu32mY9x05KqlgE2zZUgLoVByA1bC3CuD7OUb6zYnFDPQkMg3yhy
         Ot3vOvFODWhrOWc7+PpbSIYI6wCnB/SEq0hQElzBrkf8ngd0muyPZMiVI91MiYloPJXW
         4n8mh87brLzmXgmNZq812vLttwnjFNkfxcnm6ouIwgikNvXx/ToASlWhzaCNhN+cDyRj
         d4lUHiifWVFZaSLgw58+HTWXON2WYY8aciR8AbI1uzU2cbKJNOYSehEJ9qX1nSZLw073
         W9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298947; x=1777903747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NsTJtYOaggrB9DsolhFtis+hmXinR1HaOkGeiY6ow4=;
        b=T5bscQydEVjGquvl1ssJsGS/m5Dgb6QZSPWhTkI5V5WGZD76U9UUuM4ktZKJmnbpxY
         Sr1hnIkuGm0CqYNP53y6tIK6lf3asm/D5R+IA5SWgbC5Lyu9btbQycTeD77aaPgHqhsN
         UWNI3Q2yPiE/c8R13zj65Yb3oYK4CJH/ZHqbry2sjNXfg9NBTUZkhBAnIu87ht/j3nTD
         ImrMiXoTsC2cdqg+Zy3TbWOiLk9Kylizpz69Ty7oNYZcVpcbvX4WxHSmBWbM1Lb+tiRT
         Ezv/F8Px/0QU7mghbKNs/+DuNX9ej5iVtO2+nv7mIokFGfeYnU1LYMxPMusNwkHKD9Ad
         Cvzg==
X-Gm-Message-State: AOJu0YwMRRjwfXDYMcdCxxRW3HsgVP2z4CFxvEb6kqVZKeV5g0S5y+UY
	kk+TEEdhCIAZsmnN3SVZmfD86pVW4xiIa35RdJVYLvor2kClrPnEYetv
X-Gm-Gg: AeBDiesjcz0WQOfTHFntAnga4QXYmRcjJeKkV6v2Kk+uz4/aR9YuXNUKDuJan1yG9Gh
	xDSpOQE7ga46X3C1D2LGlfLq9cTquaRH1PFbLjCpELgHhg3d8o0oeKiIwiSOHmB2MPhjCRstAXq
	YbpcO7Mt0Wad0g9Os+m7ohpbgVLJjZH4Z8NCmKSeWAzGPT57QLQNs2UsJyVspSXFtTrrPcdQb/X
	OcBRFbBYJFR+2zUL7CoYtOmSwRX77YpkZlFDpARsrVFUo+S3i01LmszC+WIFFXuNmwFi9hQcq7h
	Pi+xL19YQurb9b0rdeTXTOYrbo3AHyrfOCpvf5AOfZ+D3Pu6Bk9bVZHHzBF8Gq1hTa8lKGfgI0q
	3VvYok4oXGFTChtmZ2L1His1OO4qUNNEwWWlQFzOtEHm2rwPWYmLCT6VHAeL6XlQzpiOldD7Ocg
	u0UzCmjfKHuMEROfzmn/rT9w==
X-Received: by 2002:a05:600c:4e8f:b0:489:1fa5:997f with SMTP id 5b1f17b1804b1-4891fa59adfmr461116655e9.9.1777298946475;
        Mon, 27 Apr 2026 07:09:06 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb79ecb9sm337682345e9.8.2026.04.27.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:09:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 Apr 2026 16:09:04 +0200
To: "Xavier Brouckaert (xabrouck)" <xabrouck@cisco.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: BPF: writable uprobe pt_regs context bypasses lockdown=integrity
Message-ID: <ae9uAHH32FDshyLk@krava>
References: <DM6PR11MB4722C282C0F20BB23F54A87ADB362@DM6PR11MB4722.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4722C282C0F20BB23F54A87ADB362@DM6PR11MB4722.namprd11.prod.outlook.com>

On Mon, Apr 27, 2026 at 12:39:33PM +0000, Xavier Brouckaert (xabrouck) wrote:

SNIP

> Suggested fix
> -------------
> Gate writable kprobe/uprobe context behind security_locked_down() at
> the point the verifier permits the store. Two reasonable shapes:
> 
> (a) In kprobe_prog_is_valid_access() (kernel/trace/bpf_trace.c),
>     when type == BPF_WRITE, call
>     security_locked_down(LOCKDOWN_BPF_WRITE_USER) and return false
>     if denied. This reuses the existing reason and matches the
>     intent ("BPF writing to user state"). One line, adjacent to the
>     kprobe_write_ctx flag set.
> 
> (b) Introduce a dedicated LOCKDOWN_BPF_WRITE_REGS reason at
>     LOCKDOWN_INTEGRITY_MAX scope, for clearer audit messages, and
>     check it in the same place.
> 
> Either way the check belongs at verify/load time rather than attach
> time, so the program is refused outright rather than attaching as a
> no-op.
> 
> Orthogonally, a CONFIG_BPF_UPROBE_OVERRIDE knob (mirroring
> CONFIG_BPF_KPROBE_OVERRIDE for bpf_override_return) would let
> distributions opt out independent of lockdown.

I guess I can feed this to claude and get the fix right away ;-)

makes sense to me to fix this, since we already have LOCKDOWN_BPF_WRITE_USER
and changing user space registers is on the same level

I can check and send the patch, if you don't plan to do it yourself

thanks,
jirka
