Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52A22301
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774828286; cv=none; b=GqVjQCYRnCpWIu4G/unHBHcl/aAMcxIkjBgETuCqb8KKHYKoHAdsWEvr18pVQ1uHK+oxo1t+zzhQ76xtxWdspMC1agGwfwhW6/UpRAWAllsC58t5s1SekCXfLoWLhm7+ceVw1we8NhkTTIB+1yuHajvuSmdIoi0EWziuElQ/IdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774828286; c=relaxed/simple;
	bh=jt13bEggq9NphlzoSlwJ5LQRzlgrPbtRDFY4lUp7wm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQJqCUKifXd55Xc1WRQwDNpPFR17LLUXxeemWjGDsZg9PEMFd2zS3CRC+X2emuZYZW0651RT9NiYio985W8tsppnl9XuFoqgWPg7v2mnNHuJZtm4IXyGmjFvuIhu6eNDBbjgXJgqfwS3myhD+oUngdep+vyC495k7MP8BOb2B3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX6OCXhR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX6OCXhR"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82a7539851fso1723808b3a.1
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 16:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774828284; x=1775433084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/hlFjLgmh1Rquk9APel0G4sGpiXC/TBoZHLaogvCIU=;
        b=XX6OCXhRD8aV0Sm/Z3mAJbIaWGeSCKdCvnleeChBexmLJBxaDNOQGVrXdZuEDvSHRt
         uYlT60jHrYWbFmH2UhfpaTfdSB5l2Pu07vzews02BhzNLh38evZBRmf6zVet6N+4i/ww
         P1zy9UcEQoMlZAmZ8zxec2dGnx5CPNaoXbrIYyLuw4oG8NEeNK+JC4Uf8Pc7oIkv0CYE
         x+O7WZNq882Weu1dkpe5BZj0lyCSznwyqTclietKOMCogQjSUeYcHjCPqwoZA2ltuU5W
         jtCXKBvNWimdQi5cMKlfjN3j8BAfn9X/fmUKgizquBurinfLQH1+oCEKfG3V8N8c2q5W
         SNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774828284; x=1775433084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y/hlFjLgmh1Rquk9APel0G4sGpiXC/TBoZHLaogvCIU=;
        b=H5i4kVa/BsrMslL5Kwe5s8ojUYdrvBW79iWaXef1EL1emCABeOTJU63PJ8Do1soKhY
         erjkLyCPXcWA+ZNM4XgVhcf2wqrZxgwF0HC9XxIUIh8zT7NktOj4erqkPrHyLmKaNbYE
         6ooBG+jRb1ld6NxQhfsI5L/eJDL210qTl3YrAefyAHuDZXGAUeeqhMqhJtQIaULicVIy
         op1eXcnlxbaipOfAkt8lRTAv7Z2gQGcpnvqVHkvhnY60eE3iqUe8zl8ydy5dbtZwQ6x8
         hlvPHvp7rm03wXWf6waY5BdTNnd3Ova+zxlNseagu2wXAF2wR8lQFVj9+OA84dAISjQ6
         eEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBHt88J1wByj0SPeDmpxA25UJXqRMRdquU5/Pg0zlrDpNmYYe2C0bU3jFprGE3oDE7xaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJlv+5xgJFCOn+tZElCmOvN/NEDpkqXsq1Qipk93GaTc13T+8
	0jADinbl1iD+zQu2Zt/IlbmwOgEPNosYGsGvg923MRlWVBdPhfqG+9Ul
X-Gm-Gg: ATEYQzw9EqqIfghsdyx+41A2gh3FTVDBfYza6crn8mI2qdz1016YL1MNF1txUAkcptk
	ZbU+xrCi02Rv4mdQ9lEyUreslb0jQPa5Zepyf+Wbt7SwCgAX5c0lwpyujrDzIEn2cD4LCT1x1Kw
	nbEghwxkBJTEQuXt7Eh1qRffTeK/JDdgVHHrKgvE0Q4AVR8N9UqgV3eHpPCj5wNrd8NFJS+Pcwc
	dLioiy+3VYqPIh2HhpTD+eOi36e6gfsGIDgbl0XT1Cv++DDVQNdVfgrBuJnmmGahk5QaeN0Y2qI
	QNO7DrcE7ndWdvcrEzjgZcK+hl2ar9LQNamSQQY2O1Mm59EyjUlqmXbYSDTMSRyeBfSIcPr4PcX
	7gf5/rICcRRbeFz0uHAd+eXNaQaH8tL+9I3ZDis97LBWoLZdQufJm3BK66EtCOaDtAscIr/rfve
	qrvlcoFfvQ5vTYe0nZVmdjsF6JiVDlNvyqwfm4
X-Received: by 2002:a05:6a00:3391:b0:81e:7496:f826 with SMTP id d2e1a72fcca58-82c96001c20mr8815092b3a.31.1774828283879;
        Sun, 29 Mar 2026 16:51:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d0850sm5165945b3a.31.2026.03.29.16.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 16:51:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 29 Mar 2026 16:51:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
	song@kernel.org,
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH V10 RESEND 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Message-ID: <677adece-454c-4edb-9ea4-6bd24a3ede46@roeck-us.net>
References: <20251025192858.31424-1-contact@arnaud-lcm.com>
 <20251025192941.1500-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025192941.1500-1-contact@arnaud-lcm.com>

Hi,

On Sat, Oct 25, 2025 at 07:29:41PM +0000, Arnaud Lecomte wrote:
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
> when copying stack trace data. The issue occurs when the perf trace
>  contains more stack entries than the stack map bucket can hold,
>  leading to an out-of-bounds write in the bucket's data array.
> 
> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
> Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate skip > 0")
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
> Changes in v2:
>  - Fixed max_depth names across get stack id
> 
> Changes in v4:
>  - Removed unnecessary empty line in __bpf_get_stackid
> 
> Changes in v6:
>  - Added back trace_len computation in __bpf_get_stackid
> 
> Changes in v7:
>  - Removed usefull trace->nr assignation in bpf_get_stackid_pe
>  - Added restoration of trace->nr for both kernel and user traces
>    in bpf_get_stackid_pe
> 
> Changes in v9:
>  - Fixed variable declarations in bpf_get_stackid_pe
>  - Added the missing truncate of trace_nr in __bpf_getstackid
> 
> Changes in v10:
>  - Remove not required trace->nr = nr_kernel; in bpf_get_stackid_pe
> 
> Link to v9:
> https://lore.kernel.org/all/20250912233558.75076-1-contact@arnaud-lcm.com/
> ---
> ---
>  kernel/bpf/stackmap.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 5e9ad050333c..2365541c81dd 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -251,8 +251,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
>  {
>  	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
>  	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> +	u32 hash, id, trace_nr, trace_len, i, max_depth;
>  	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> -	u32 hash, id, trace_nr, trace_len, i;
>  	bool user = flags & BPF_F_USER_STACK;
>  	u64 *ips;
>  	bool hash_matches;
> @@ -261,7 +261,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
>  		/* skipping more than usable stack trace */
>  		return -EFAULT;
>  
> -	trace_nr = trace->nr - skip;
> +	max_depth = stack_map_calculate_max_depth(map->value_size, stack_map_data_size(map), flags);
> +	trace_nr = min_t(u32, trace->nr - skip, max_depth - skip);

I stumbled over this patch while researching a bpf related crash.
I assume that the problem it tries to solve is to prevent the
"skip > max_depth" condition.

From the context, it is guaranteed that trace->nr > skip, so we know that
trace->nr - skip is positive. If skip <= max_depth, the above then
constraints trace_nr to the difference, and there is no problem. However,
if skip > max_depth, "max_depth - skip" will be a large positive number,
effectively making trace->nr - skip unrestricted.

Is the condition "max_depth >= skip" guaranteed somewhere ? skip itself
seems to be provided by userspace, and stack_map_calculate_max_depth()
returns at most curr_sysctl_max_stack. What happens if skip is larger
than curr_sysctl_max_stack ?

My apologies for the noise if I am completely missing the point.

Thanks,
Guenter
