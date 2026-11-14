Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686761;
	b=D+3/98uEaggbyJY5ohp4YnjBoAI2UFEG+5d9pHRM/VlrxOy0cSJnP7l6REo3vzxeg9h4
	 8DDDnjDODn5S62nGHc/GlzEYjEC4rQYt1DRQxSzj4cY8HHIGrOJsTpuXRJXJvlGwEn0+8
	 SBiQ4j5EVBbOyInviheOgPajqmSot1/hBb9PVSLyYsZBCrO+nY0v6dsNA2Z7x1tHZWaBi
	 yTWFdKGlWrxKNvcY/Pa8sgs0FfidMITosJpjy4tJhOj/8A78TamHyJLX7YbTepXW+oj4p
	 rOlmvDc1GIYuqNcOImFLS8HSGE3+9qMeP6aAENOw/2wThkH0kAzXkZKwYXss343QYEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
	b=cxDa9l0CpX1q80w/QDF1XOvpjafgYR2+Dq4UFgKL3VmKVzs1TdRB51Ms5hDPW1sIKA33
	 5X4DgtItV4jMnaqpdPjNZd3VlfE+9018xe4fgsqJBjlM1YVDF3u3frK8B365US7VWjuOU
	 wdX5jCHnrKVvnRTDPRcFC87CFgzeY9jdPzep3rjaKOdnfqyavdV3DOgX04Rt1dZAKc4as
	 EvslwUzR60PScRq4cjcWAHi6pPKYvNKIMm9tJOksVgS5Nx7qcEyH3lAh3WF+iALbJTqYh
	 UiSon6dK2G5Ac/CqqyEBtnwYz244DVaperxR4sKmlBd7SEh/FblrKpBsJlZvrXJNlug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96635606A886
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 20:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96635606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso2097064a12.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686761; x=1795291561; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=WyNKKpANsG5sdrHWGAt+Y38DvSIGt+WnCUyNYCZoBM4YbSq3wCVAHI95jQ8BFTGgLn
         +vM7af/q0i5zrzjZXXnriwzXN4L/RbeBg/iztvO0eyeIXYNiQp/OYlS5LD9yZqr2gKgm
         1I+5A88e/cV4J0nLZfgp0f7sQwj9jY0Q4quBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686761; x=1795291561;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=hejjwrAvZXGu2yqEAbuoNPAmXuuMdrFdYd2HcOfRIufzHSoOh5xdgQxmuApwHOAynL
         1d1FJfJnb7moRPT0/pWRjTnLgrKFKUsmJsVPTWGaMZ0QsBgFfiMnekFbrhaW+rB6gUmS
         MCvf46m6RaizpHtvRT+ZhyoYyZLRKu58jQF99H9KIixJ7IX4CKLSacqEKlWYEKybLP2h
         h4Fe9fgslo1Sk81i9I478NWrXDBfUUPF5ZHQsPoNPRpCXocB+/tE8xGaLTTjZw5cLfb/
         BdSn6zh5YFN3aJEac8Haf1zMcxXHMCfhptmDK77kyHI+fjSrtXKNv2oajYY60Pld029U
         K34g==
X-Forwarded-Encrypted: i=1; AL+hErHiq/dpEc99Lt1+7EL5pdq99blxHpTzoj99V5LES6yLg/zLEjJ8yY86FrYIP0wBeD9Cfu4=@vger.kernel.org
X-Gm-Message-State: APuU4Z++WP7qAk0XP4ucKDBlTIwtxLUkhE4ZfohL9YhF/feFvRV+j1BW
	NtxaMMPNcFjwERaO1oODZze12hnB4io6FtJt1kRXsK2+VkpsIBxioU5DORekoKexUWM=
X-Gm-Gg: AYBFou0PmHFOUTaz6DYGNM35gylh4D4C2ybTj7b3gTLQPqkkDClA8F4qFqTDfUr5qbr
	OClUVjqTJb9S8NvhaxOJE7DBNURfzsPJFZkmkixti3WqFyVMK1mmFQ6jnWoZcWRJOojqhouuir0
	6RAnG8FQB3Mj1S+7eiPHKiFgMi00QLc3tXEYP8O6f2iIYrd0aBbZYKdrCAZU4aoThiZ6wYAa/nw
	39JTBWskVOj+oAeBtBLhYiJGi6+ttK+bgieJTZXUuod6ykaON4aIPVOy57rti0Tg2FrnzcZBQra
	5FAVrPpV8nLc8pH3+AeOfQ7s5aCm3BBHccKt/w1zYFkLP45BpdBVHl3WkTviOJqMuEJgFP3H9tJ
	9ZFKrDdS0TtP7UbWDZCh++3Xif8DZnsqSZUfUNiILOrAHsaL0BrLb883j1rJn/jfgHU0oGAEwII
	n9GqRWs/vobhA7cQXnG1hu0VFetxsLzAIm3IIGsUrUMSFgQAYoqa4pWPMP8y1j3SsimoEWn0fXc
	PypBbcRf2Diga+CP3pdOFKaYywP05pUXbZCIzCIxAInKssr7YZXDtW+UPRtQLD0TJTC4NPaakcm
	cxGC0mVzZZUxMi11c3w6J6LmVHNBnFLt/8+EPRYf/DoWLQSWHF9a5WT4STaZjDLv+pg+ro3EBgu
	TphFJ5MLh6ozFFyi7ElXVmCMqIEvd/8LBELRynVx/1eMHiwzJiSXo724lxTfWlkKCQgr3JI1Xx/
	WZmToJBgOpmq/UnP0g/vqQbqP656ZiUp3r0EaPbudsgT3uA3on9vLtpYia
X-Received: by 2002:a17:90b:2584:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b1b0ba61famr5629200a91.33.1794686761104;
        Sat, 14 Nov 2026 12:06:01 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm5258887a91.0.2026.11.14.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:06:00 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:57 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
In-Reply-To: <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>+	/* Look through stacking filesystems at the inode with the data. */
>+	if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEUDO)
>+		return -EINVAL;

This looks good in general, but what the bots said about O_PATH files
here is real. With FMODE_PATH this is reached for a file that was never
opened, so on overlayfs nothing has been through ovl_open() to look up
the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
itself, and when that fails it hits the WARN(1) at its end and returns
the overlayfs dentry, so the check passes as well.

Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
it's easy to trigger with that. From a quick test with a metacopy file
whose redirect into a data-only layer points at nothing, registering an
O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives

     ovl_d_real(/f, 0): real dentry not found
     WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
     [...]
      file_check_backing+0x308/0x5e0
      fuse_backing_new+0x219/0x4a0
      fuse_backing_open+0xe8/0x390
      fuse_dev_ioctl+0x53a/0x7d0

and the ioctl still succeeds. A normal open of that file fails with
ENOENT, so nothing could have used it as a backing file anyway, but with
panic_on_warn this is now a panic.

Maybe ovl_d_real() should just stop warning when the lookup fails, now
that it has a caller that isn't trace_uprobe? The check would still pass
for an O_PATH file whose lowerdata couldn't be looked up at that point,
though.

Thanks!

Chris
