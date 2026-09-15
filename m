Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDC41168C
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494731; cv=pass; b=W9OUVJQcphNfAR88Yw+Hb5PSNu+mcu6qiB9DR4S+lOt6iqCLtR9ASfN4HQw5ZJBDPk8IPl8edKmLUJojCY3FIK9LcaCqNuSU5ugwn4gzT7OtTpPDhR43Xx08LUJLinH/yPo+A7YwDxVdHrUtXiquNFs4H7vnpmjchZVTwwz55Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494731; c=relaxed/simple;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQjsuqpLuh89DLGq0UIMVPqGWaFF7rDlCTyx+a0nDGp7IqOWW2qfh3YyQ83QxS3k9IvJ3cTdARVbHTU8OOdLNI5Ybjk0JFhGNkFzKC6DSd2iVE/X5F3WLjqsGHnjR4PplrrS6HCXX8jNj9nNST/1Wo426slVDHB+ySEqGQIQXZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPgx9Wh6; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPgx9Wh6"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so12045ad.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 10:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=EzzFffA4CAxestDt1qdY3BylRtorDXR5lMsSIsnw4IIwbf65M/tA6+CDyhY551IsHz
         EiKXs+KpmA3YHuuvHhDkO6+lCuahZ9fKC6E+5YIT18EUMwnTAlSzFsHwpa9+JFVfknOo
         tM3MNzMIRjKXcGwD+lwX3BbLv62xkkW6URoschkTj2O+vaN5Pp5LArhc0DetiK0vXGGd
         d4x+xZvFW+fFKcwRPi5Sx+FOOSJ51labGp9WhXQVm6RgEQbbsR7MGNiyyzQnuJg13DNl
         q3CFJ1PJIqmYX037+j2Gq0vHR1FDE7UvVoyzzmctMSzQyFFYHo8pvksu7aVIhmsJxBDT
         2AyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=oqYX9PBXB89sCvfAOzBVa7o+f9wVTNuvsTbPBJLCqaw=;
        b=eKzcBDJ+AUbFPOWrbwQCUec9AbRwBblfPXFfs2qU4HIoaK3EJyp8DCANW0D7DTDcKj
         Duqj3KIhocpVfh5r2Oji1MLR7SLgLjvw5+MiAuMeaDhu8F81pF3h2VMncCrtJUC8gMfo
         6tteSNGZxZMQtSfqWsvIow0bLdq3qjVZLATlKUtPUYmB8I0hXIUwYRleilLK7llX9ixB
         0D+G7cK1CI7R3pCaW8Eb5yTvSo17rq3J63PuZHLDtMLXod5/mvnHazL76OrMD3+6c75f
         q3xQIJJ4agr+bCyBniISINrRLzDlOM/zwbS0ZWrKOtJI39T3PaOk2ZM178X9bXiLT8os
         eo0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=WPgx9Wh6g8ehXMOaZf8ZSNtevHb9fzr3lXk5INKsJirqC99dpiARLSwTsIwHA4pbMW
         JbWx8MvBxDUFu6opqA60njTwuSet+XjH0Wga4OKXeEmVhOXoy61UWc3rqiL6EU8/l428
         EjMY1UqvowxmFEZiD+cpXVE0I3gM0Ssco82ZH8FSIs0h6jzSdSLoGG2b/9Ga+W+7Aup7
         R3Y2jKX2VRyqaVjVjF8po02JGQLWYioBTM31SQGX//CGOHsZjgwuKy0KaaC3tSzQflwo
         ISJi8sLOMT0xayOGlmIx3TnuUJAs8/tTEps0xY78QDJPw7a+XDrg4k1OSruo0M4Rr9uE
         eRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=MlJfnVotuRfnv21uW2q6R1BNp01p3xE9G8uaPA1wbYyOpHdEaQCyYWyguGzwasvkz/
         APDXaR416GCn89np5Dv9wDd+DWfdQfNZKO3ygG3votkRCo8owYVcrUEmCgeFfLt0CQQh
         FKl2/TAarnn7KoNTy762JuhQscTGsZe9rs9qQe6oBb6xbdk3FPP8iQCbiMVHTcrrPEh1
         SvmLZWqM+lR8fWn6PGbuHJmg7UEPbU80L3rYrOw21hEPnUUXqMJAGc7076y61m2endX0
         J9TlkXlRmGtmuT1mrOwxo/SjIqHDwUYCrSBYzrYsKLZeGYkKjVlyNx8cBC1AIW7BVG9w
         2zLg==
X-Forwarded-Encrypted: i=1; AKwUvBwF5sK+g6NeHYGeNDVBgEYiTwe8ova1QEn5tq5yBG1KoHRDH7dthHsqQQKyQgbU+wXtZL8=@vger.kernel.org
X-Gm-Message-State: AFuF++kC07Y1ZC91GAao5AwsCCS1uY2ttciKMDr7+o8d8v2pPvW8ppQB
	ft5LEboAJN7NF+o0vL+KT/0MdH4nA/eN5j7aUAP7MqTWq4d5EkRn0IDdmdRhFZmP96/xacfhNES
	wEVp19KlBbXMk+in7R0qiQcaWFa0LXeu1jxmICSlz
X-Gm-Gg: AYBFou3Nx05O5numxzy9/36NSmuab+1gIQmA7fRkujDeEH/cRaunoHJBofVLQvbk4n6
	oMOBtl98ujPH8nRB8qO1SwwkKjk3nGaR9CgbLhBZVtzUsJI/C1C7+09niL1EKhHa/LWNRKkDZRd
	7Ix9uBO70QiDEu8lJfac4GKO7a8yk34wzTX4JxEkBDTvThejGr8SIFrhrrh5ZAQokejFv4FdXKX
	e0lAikD/jldaovzDxIMi1N/ADajTLq2Tm3YHXAH5DBpkWlAZL+ssKIAfAW8fACWoF0tMJpRTmt5
	Ca39PQoeLFBVPfcAvcYhdeAYlFH1qjbxZxmwykbL3tkruCtHuA2qSyTA3nx+x9NLAh0MuS7KWe6
	S3hmPoTRto/0UGfZKgybygD4CX66ODBuPVnznrDNklIKWStdz25g=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.
