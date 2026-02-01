Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6D221554
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769980361; cv=none; b=gM7T5xLg3stdVhPVILVTPsc3E1UdZfyp95zxEtqjBIdSpLe8a+mOPC7hX+XbzfTUC2sDQCfQIJYiTyiOADUwSsBHknnp8b3iHjpJjJh2DGCcq2r7XRkyywTgK4Kza2jwwl6BL5f+frsSKovyyK6hksdt3Nvh9HALPiQVv52OJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769980361; c=relaxed/simple;
	bh=a7T9Mtp7+Cd+E6kyOhTLY7w99/qCoS5F6UZV8AdIek0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9+koYXmhHu0CtWZwnzzFsoJNjgvZzJEzf3q/5vSP/tLorRRGUQCXhVcgrUSmsVSXdyl+0PH1vwL7ETE2xHIa3OH4kyXmlgGAMmUbAHVAufTNk3BvEMwkSpkdbYRT8bVfOjhsH1f9iZzNPbx/tgjhzGrvAh+YfL+14apHdLnBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fyk8/QT/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyk8/QT/"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so3954755f8f.2
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 13:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769980358; x=1770585158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6PMLIUbbhxWYDXz9TON8h3cYfNXfcLRPc4BPVL3NU1Y=;
        b=Fyk8/QT/lJT8Epid4EPoTwnPuQrSLG3uQ9+4V2Zf0hTV+98rFn9RLPZYGwgi9TIbJ1
         slzJpsqzwM4eeMX0GnNN75DDtKxRQqqMogT0SeA+vDCvoxkke1B7WP9Otbq6TPoa5R9d
         SxR+x/3eKdcupKqVik211U7npjspwqrArPc/1oc62avIQD4dgYi4e4A1L8CBpnfQYDxq
         /TBmK1+9oLqx4PKVorKJiZnmqJH+XpLfBGgz29lJ4LImd4KiZ3FW/DkjA/BRtnI7Ivym
         3r7yeN0reD8Dc20QWHGfdqpvuTYG2yJ/4vXhEqFr5XiN7VmhQMX6zIjc+19UtqLP8qG1
         pRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769980358; x=1770585158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PMLIUbbhxWYDXz9TON8h3cYfNXfcLRPc4BPVL3NU1Y=;
        b=XEFmwdTJbo3eAn/veIOhJz7xputqTzSFFxEAQiNrZw5ee3W9P7NARhsgD4kJjyxAPu
         wSOHtCrF+dN0UnWJnJIbFwTxIg7whRgVf0nmk+ZrYXEEqmmTTI41DB2csTlSpPJqxHVf
         cj3nv6O9en8TBA5APNFmVDYWSkjR7gig9WUZHXmoha17XftZ9F8UE1z/l7efRoGodUt6
         +fnFDAPaJozVngayOValnWD9ZeorBIbzkivJW44xpoTp7vkzuq3DKaRiJoXa4KwNWPbE
         qtSRFL9gYvhJbsD4hKCDKw/WEnTjm6ZpN8FEOZjCCjuF2eWy5QPgwUBSWzbt78UjWXiP
         vXgQ==
X-Gm-Message-State: AOJu0YwINCnMNaD8Eo+fOc/+dul4MyOetFOKYZkGpj3IvfSH5I4O0d8q
	4ZEp+gtvHJh+WMXqV1MwbRRWU/tx5LKpMZKfBaXj2eSghfd7cqdoqWnu
X-Gm-Gg: AZuq6aKfI8QAvE7ZYDyK/Xg311TYe1ejsLI7RCBllLhGNw05Y5p1350+PzmiCMp6p+g
	XMitNl9Sqt/crsVifWVA6Pjuq7gBoJhJEbZnkfV0U9jOQsuha8MGuY/eIo5YTXGEz8XChFarM74
	dv84FEJPAKbD6JMv3GIgOiSpt4dT4JhZLXNLOjHvKwRqs3J0m1h8FjtsA3/t3PEMQ5C8LGJL+56
	WL4cqUkhfP4qjfo566KEz1jn6UxbOTfVBnQCGCWlxMswjtad7VzQMLULjB9CwDQiyABDdnWJ1dU
	BE7szNGujyAfGAsUzLrItahYnfSHXJkyPgG70Sa8x+z4R+VIk8pObQ9qZN81zJz1sizMKHBMnvn
	5Cz222LMUjNtf5xVeJwYuCz5REpWbF57LrbWlCyo8MW682T0vtf1ZX3XjlV8KbmZx0hnOiPCaST
	k=
X-Received: by 2002:a05:6000:184e:b0:42f:f627:3aa3 with SMTP id ffacd0b85a97d-435f3ad8530mr14022312f8f.56.1769980358228;
        Sun, 01 Feb 2026 13:12:38 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee04csm39225222f8f.12.2026.02.01.13.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 13:12:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 1 Feb 2026 22:12:36 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: memory leaks of ftrace_hash
Message-ID: <aX_BxG5EJTJdCMT9@krava>
References: <CAADnVQLVYsosBeGEhB2uxyOKNB9aS94vmR9bQb7RY3jVR2iFxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLVYsosBeGEhB2uxyOKNB9aS94vmR9bQb7RY3jVR2iFxA@mail.gmail.com>

On Fri, Jan 30, 2026 at 07:50:13PM -0800, Alexei Starovoitov wrote:
> Hi Jiri,
> 
> I see a lot of:
> unreferenced object 0xff1100012c967540 (size 32):
>   comm "test_progs", pid 2052, jiffies 4294681345
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 b8 be 65 06 01 00 11 ff  ..........e.....
>     74 3f 5b 83 ff ff ff ff 80 0d 01 a0 ff ff ff ff  t?[.............
>   backtrace (crc 8dddf0a9):
>     __kmalloc_cache_noprof+0x3a5/0x520
>     add_ftrace_hash_entry_direct+0x4a/0x2e0
>     alloc_and_copy_ftrace_hash+0x15a/0x280
>     hash_sub+0x3a/0x470
>     update_ftrace_direct_del+0x349/0x7d0
>     bpf_trampoline_update+0xa9c/0x1070
>     bpf_trampoline_unlink_prog+0x287/0x600
>     bpf_tracing_link_release+0x5f/0x100
>     bpf_link_free+0xca/0x300
>     bpf_link_release+0x48/0x60
>     __fput+0x2fc/0x9d0
>     fput_close_sync+0xcd/0x170
>     __x64_sys_close+0x7d/0xd0
>     do_syscall_64+0x46/0xfc0
>     entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> just running the latest bpf-next.
> 
> I suspect it's due to your recent changes in the area.
> 
> Pls take a look.

hi,
argh.. I had kmemleak disabled due to small CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE
looks like change below fixes it, I'll send a patch

thanks,
jirka


---
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8574932e66b6..b12dbd93ae1c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6537,6 +6537,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 		/* free the new_direct_functions */
 		old_direct_functions = new_direct_functions;
 	} else {
+		old_direct_functions = direct_functions;
 		rcu_assign_pointer(direct_functions, new_direct_functions);
 	}
 
