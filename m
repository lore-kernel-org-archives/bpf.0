Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0030ACFB
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778763; cv=none; b=K7gdyXlF3ber63PBLamledJw3kfkPqIeZHVHO0UZKxMXsQOaMMwTawmACtybuExC5/GvAcb3IY/vqgx2NmFd0vNoSwIePIxC32OYUzO0qOZmP8WjMJJvgIduOxcSq3FzdbDaCyLeSkzV40ZJlS52ErD8xcA379DHRVUruYVa6/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778763; c=relaxed/simple;
	bh=IluLGjsT7RZdSCRqAA2UzZd+nB4XSyCNHTZSjlQFFJ8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Fx9jQSfq0jH3KgaTDOLDt/ecV6jpHKGLUd7shVtK+jvcQEQLc7qu/jAWChHyGatRs+ijjN3UjPzpqhbCy3wvnDR2qH0qRgU+aDZYkz0F5V6ASesxjrt7ZYXm/HIy7pP4Mgolpl+ONyEMV00Fx2DGd3bpisZii/FW8JJsfMT2A1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjDH5tUh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjDH5tUh"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e347638adso184497a91.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784778761; x=1785383561; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S1PEBsBmBuzQnOjcMzNDPNdLnwh3q1jmxZTOFvMDrVc=;
        b=GjDH5tUhFu7dCswD25/ITnXyBMV9QAVq21g0eFbBYFFemLSeb+nsO5lkyQaPTh/X3y
         aJlRP13B3dPvsVO/1GnyuEZ20EY+KTGgabC6iUbijBV8BmGL+Xehow19QofkJXmj6/Tm
         dX17yJBieGWNp0fvgfbA39fksavXrCxCLdCwilK5ZPmXct4VBAT3FN7TqYH6wlK9I4CB
         dBStWZq/QJYVeXNdQmhYxckgWc4jsNk82B2+S1G96C6vQmbnV5gSHDKvjlzUHVWWgRVi
         xx9KnEAyLvpkY31vGYkExFvpJjUogSxsZcdCsBV8nC8DEfXkmpJcZcgpYU4v6V4j+Kni
         36/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784778761; x=1785383561;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1PEBsBmBuzQnOjcMzNDPNdLnwh3q1jmxZTOFvMDrVc=;
        b=KOQ/N+bO9/fIGgbkWPHGrYLzZGvx5yVqhvuurvzZ7Twd6W3JoAlRWAsLHjsYHMZS18
         IA/tNDWJbONtHpyee+/bq6AyYTrrPxRXJ5pjG42W5NIPcIYNdTXu14+Dxp+1nQPgTKI2
         8tJEX5CEbNO2qNgCRfpXrCfVbHbgr0IOJuyiVpKjDlCArV84ZcBqjaWSPK81eyCR9v2p
         AMbDRRo4X/yFSDArRADfBbN8QYI6IUCbUm/zg+Zn+n+H9TODEq5+X2/g5I4DoYtONNUp
         d34T7RisQhHGCp7HoiGlyYKCyrhX3XDRo/bQUiYGp6FYqa9zt0gKrHiQ4UlhcfCpYbBI
         QaiA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5RwqOxP6yst/LEVQP/xbn57SxAIl4siFbLRYaozAfCZY6ROe1h8QPzLzksQ/jE/qvgcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7FBzPmBBi0IIU2Tm/6UshACigyCzP92nNqdno3DeGI+rOZwRY
	f6ZyrGO4g/FTvcohQGV2Qomk916PZ2GpuIMWNjIz7HqWjrLJe1AOSPZW
X-Gm-Gg: AR+sD13HuAdrZABIpn6jg8s0DB+j794sJnfMJHt/ZPYEo66VPRhavadnAwnWelH6wbs
	O1p9+UXBoPYNBnjoAQjDE1lj7Wz4SXNBCBLczL2xpnLVie67kYjxCNYqaICAi5UILDlyrh7lptP
	CqREbBN+vEGMuuDtxfL+gaL/UcDSCwyT7IjL7ThqouNHsDtwDJpyh5nuP2djkiXPcyMHLT0EheK
	JqGuQkdiiC7024MAjtYRfV1nruBXYHH2WJzkQayFoZ62+pY6oXU8/7HTFxbbq8HpR0ewbkfd+t9
	BSXWoIyR5oUvwwbhGr1o+YSdf+xHo1edbazgJAu0MI23ZpYORZji1eYwpZW1hNQPFo2XoB5owhX
	q6cKBMW406770fSYQWFuHPCeNnf9BAO+mWbWwcPjfyqnH4Mu4zY2YjQWm9o+P1B0CnmHju10BX8
	I1Dazk6g==
X-Received: by 2002:a17:90b:3cc4:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-38ec642941emr1497129a91.11.1784778761575;
        Wed, 22 Jul 2026 20:52:41 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d12f267fdsm11497359c88.0.2026.07.22.20.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 06/21] exec: release the replaced file with
 do_close_execat()
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-6-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-6-e57866e4ae0f@kernel.org>
Date: Wed, 22 Jul 2026 20:52:07 -0700
Message-Id: <178477872732.254289.8598325015704574885.b4-review@b4>
X-Mailer: b4 0.15.2

# Add your code comments below. There is no need to trim or delete
# any existing content -- just insert your comments under the relevant
# lines of code. Lines starting with "> " are quoted diff context and
# lines starting with "| " are comments from other reviewers.
# The final email will be reformatted automatically to include only
# the sections that have your comments.
#
> When the format search stages an interpreter exec_binprm() swaps it
> in and releases the file it replaces. Dropping the write denial the
> open took is done manually ahead of both release paths. The one path
> that keeps the file silently relies on it not being called.
> 
> Let's just use do_close_execat() on the two paths that release the file
> and drop the denial explicitly on the one that does not.
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 41e1684d9..061e0f9fb 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1735,15 +1735,17 @@ static int exec_binprm(struct linux_binprm *bprm)
>  		bprm->file = bprm->interpreter;
>  		bprm->interpreter = NULL;
>  
> -		exe_file_allow_write_access(exec);
>  		if (unlikely(bprm->have_execfd)) {
>  			if (bprm->executable) {
> -				fput(exec);
> +				do_close_execat(exec);
>  				return -ENOEXEC;
>  			}
> +			/* Only the reference is kept, for AT_EXECFD. */
> +			exe_file_allow_write_access(exec);
>  			bprm->executable = exec;
> -		} else
> -			fput(exec);
> +		} else {
> +			do_close_execat(exec);
> +		}
>  	}
>  
>  	audit_bprm(bprm);

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
