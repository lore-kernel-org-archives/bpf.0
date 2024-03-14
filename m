Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64923763E4
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710451010; cv=none; b=tFiV0YRFl/bEfmfqeY9EEMIQqx8xzwzScw8jdLWw8EXUa26z60L5ZFzsa34YC/I9K5u6ezGLyRIPv5nZJ3zhYzVykWx7HqqBORJu7HSPNPPKwS8DJn9Qm5ukCydMRLDbbKa1s4Dcvpb6WCKFGPSTTsRQ7/bQMWIJyK1rBMJ6Fgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710451010; c=relaxed/simple;
	bh=yWx+3qY7dFErwb48NK791BS0lmrKkpe+uI6t1v3jXWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AneeIAg+iuielnYYQXrBeHuRVcsvexTiEtW9BBO1frDseu4uEr8OeekNP64PYanUKuwuulRiq/RnX581p+uS3UXmudOfsSlMEq6CM1tB/0JBPxC6S0wBcpx6LUgC55500iIoE7dlVakWojqMITPTsXQoV+ol8LsBh/ZiBz3WF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eniodA+v; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eniodA+v"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6ca2ac094so1330276b3a.0
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710451008; x=1711055808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfwwmQhKlKc+zJ1d8rlzVqfov4WkK6hD+Y4Encjtfaw=;
        b=eniodA+vj5yr3zBRydqfC2zMfi5dhjuNLW+4p4MOXKaPFNX1m39aTV0Q+m2QgyUt/z
         VmeTdolwJJTn+nPgUrdJwTLNaPdnzkpF1afa0xUacy3vqjFXM7vFdDzG+Hh8pJptDchj
         RLnpHSduadKM6+Udyr+u9eVsP6+rmAC6XDmHP34RFRiWcYhxcZ5MJtMI0enSB6Ja3gGA
         DGdhPbCi3KNX0rbiUeWXeHhrhZLU+pHmYAFWeL1Gnstfo224odRxqDnIO4NP3aZPgGxp
         HopPhqPpXNMSJHnTDjcHcXfKOe7mDURD5GT8v7fBaDncsKjvnvct1bKy17GSDI2fBFnK
         w5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710451008; x=1711055808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfwwmQhKlKc+zJ1d8rlzVqfov4WkK6hD+Y4Encjtfaw=;
        b=XSqdTx/FJ11xGIP0FRhLvvdNkLSjxzDIO5+D2WOZpbvZjPbY+q8ljNNEjZe7j8ajBL
         MQyhucIEv9hTYLadpKMJxKU7ODQtbVLVWD77TElleDgOKr2ZKewxuaHNNylfGD2agcO8
         GWHHeMhaM2dFs+1Synuj7io6FO+DyJBFPJR/2P1AfPMFZR68Mz5IIhFNSjrlggQqMGUp
         bzkt8u5CX7wNJv//DgWZ6BZn3erQGr9zKMgL98TZDLmSSfIsfd5/QEC2/q1tQ4vGbyqI
         LWsUeNGgC6wK3nEoMRCcyMdFMFxDf0hY3g4jdnvT0IPItl4pzLXq3wWcJHeAw+uhO6Pq
         UqDw==
X-Forwarded-Encrypted: i=1; AJvYcCX2bD4l20/emllSNlmXOYwuM2wUzZ4vokqwnOcWXHL1dQpKui70J6mTx6Ou8493FIaP+40qNvT4YdRVxhm2Nl4Z/1MZ
X-Gm-Message-State: AOJu0YwWG0tCqcvEAAGKFrpogDOyaH4fjaMYmLqrCzRkSZa1GB33CyKL
	lrYjhvdQjr8nHSkvat+fRKK3hEPiZvgzga18UHsNd3qtNA9JxGKhS+SqENO35Y4=
X-Google-Smtp-Source: AGHT+IHIILq3n+3NVECwgjaZwAZxvmzIU+UX648sI8XqdwHaNIXmkwjq8Bjn0RLBKBHeOMR45gXbEg==
X-Received: by 2002:a05:6a00:a20:b0:6e6:96ed:229e with SMTP id p32-20020a056a000a2000b006e696ed229emr3424189pfh.3.1710451008549;
        Thu, 14 Mar 2024 14:16:48 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.86.143])
        by smtp.gmail.com with ESMTPSA id i9-20020a056a00004900b006e6cc93381esm1864491pfk.125.2024.03.14.14.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 14:16:48 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 Quentin Monnet <quentin@isovalent.com>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2] bpftool: Mount bpffs on provided dir instead of
 parent dir
Date: Fri, 15 Mar 2024 02:46:41 +0530
Message-ID: <10467264.nUPlyArG6x@valdaarhun>
In-Reply-To: <c3cb7598-f777-4714-9e43-d9e0fbdf8711@isovalent.com>
References:
 <20240308130619.28123-1-icegambit91@gmail.com>
 <c3cb7598-f777-4714-9e43-d9e0fbdf8711@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

On Wednesday, March 13, 2024 9:17:44 PM IST Quentin Monnet wrote:
> Thanks! Apologies for the delay.

No worries! Thank you for the review.

> [...]
> Note: you don't need the blank lines between the tags.
> [...]
> You can keep the changelog as part of the patch description.

Got it. I'll keep this in mind when I submit v3.

> [...]
> With all the checks and the potential directory creation, we could maybe
> rename this into "prepare_bpffs_dir()" or something like this?

"prepare_bpffs_dir" is quite apt. If longer names are acceptable then I
would also recommend "prepare_and_mount_bpffs_dir" so it indicates
that it'll also mount the bpffs on the dir (when relevant) after performing
the checks.

> [...]
> I'd maybe change this block a little (although it's up to you):
> 
> 	bool dir_exists;
> 
> 	dire_exists = (access(...) == 0);
> 	if (!dir_exists) {
> 		...
> 		free(temp_name);
> 	}
> 
> 	if (block_mount) {
> 		...
> 	}
> 
> 	if (!dir_exists) {
> 		err = mkdir(...);
> 		...
> 	}
> 
> 	err = mnt_fs(...);
> 	...
> 
> This would also enable us to remove the directory we just created, if
> we're not able to mount the bpffs on it, before leaving the function.

I agree with this. This will also keep the implementation a little more
succinct with just one "block_mount" conditional block.

> [...]
> I'd remove/replace "given" from the name, maybe "mount_bpffs_for_file"?

This is definitely a better name. I am not very good when it comes to
making up names :P

> [...]
> I'd remove "file", the existing object might be a directory and it might
> be confusing.
> 
> > +		return -1;
> > +	}
> > +
> > +	temp_name = malloc(strlen(file_name) + 1);
> > +	if (!temp_name) {
> > 
> >  		p_err("mem alloc failed");
> >  		return -1;
> >  	
> >  	}
> > 
> > -	strcpy(file, name);
> > -	dir = dirname(file);
> > +	strcpy(temp_name, file_name);
> > +	dir = dirname(temp_name);
> 
> Here, we could check for the existence of "dir", and error out
> otherwise. The reason is that with the current code, if dir does not
> exist but user passes --nomount, then we fail to pin the path (given
> that the directory is not present), but the message returned will be "no
> BPF file system found, not mounting it due to --nomount option", which
> is confusing.
> 
> Same note applies to the other function as well.
> 
> >  	if (is_bpffs(dir))
> >  	
> >  		/* nothing to do if already mounted */
> > 
> > @@ -277,11 +333,11 @@ int mount_bpffs_for_pin(const char *name, bool
> > is_dir)> 
> >  	if (err) {
> >  	
> >  		err_str[ERR_MAX_LEN - 1] = '\0';
> >  		p_err("can't mount BPF file system to pin the object (%s): %s",
> 
> We could also indicate the path where we tried to mount the bpffs, in
> this message.

Understood. I'll make these changes as well.

> [...]
> Other than the comments above, the patch works well, and the different
> cases are much easier to follow than in v1, thanks!
> 
> I've checked that the programs load as expected, the directories are
> created (or not) as expected, and the bpffs is mounted (or not) as
> expected, for all the cases I could think of, with the following
> commands (copied here, for the record), all worked as I expected:

That's really nice to hear. I'll incorporate the recommended changes and
will send v3 soon.

Thanks,
Sahil




