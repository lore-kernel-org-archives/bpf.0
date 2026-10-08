Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD7447DF8F
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496648; cv=none; b=DWmXMqnbhUUkzYiIs88w5qWytDUV8M4pGwZXa47hAVf6xCI5/DPnnOpacqHvOeRkN5aRWTRJCSRMr0JtTBrUDyd8cW4waLUwrYo0aj0JDyB/PTYWR+wszg23jmVS72vRLO5zA8P8iuqCvrXslmkilFdHsn0o8QgUlJOcyuUvK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496648; c=relaxed/simple;
	bh=TinDgVFxFR2tgZfjdVwALy4/9vsweDfT6mfWVmqTMUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4qCMYZw9jHCUKFe12R4djaoUXBwifPiu5OlX0eqzj1ZwWc7PjXj15SWcy7/zBxxhoHSYIoEUtULyDiRTlqn4C6bcrbKbF9XnSWcbcMje1tzO9gPEbkKWzXbmTcQ1NY2UZKEXnfZ6PH6RFPQGBNN/lzS1aw887bsUNq+gXGETps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=z6qriq0p; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="z6qriq0p"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6768ced47aeso4065479d50.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 14:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791496646; x=1792101446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fco4QMlc4mAm6FzCcL+SMMWE++sU0VPdNedp39umucs=;
        b=z6qriq0phDdFdiH+a9lOEwK2s1YMdgvpqYSYv26lJOAtdljC0S8EprwYZBciwDJkhU
         VDZynNv/a1n044+ErEvfXTG3sPZAd/XibqG6QqOcRGh/J8OuSvDs0xtYkCPbsLFDinAk
         Mx3FXqGd1Rzgtxvxm6RHO/A70o0pZXhsmZW2ZgDHqgvxZ11XmEzUF0flImDctfVYhDKw
         un/tVizYPLyAR7sHKgskkf7MGVOQjN41k6K79CxXoNDjOxJjE8FcQJT9iGn4IDwjyu2K
         1HS/Z+kzyoQGY18Iwfpr4gaiTU5TMU0HIBYlRN8QK76duawAFd+uFPXVZhxidemnLcqM
         1bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791496646; x=1792101446;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fco4QMlc4mAm6FzCcL+SMMWE++sU0VPdNedp39umucs=;
        b=SjLlePpiKkoVN7xoUH9P84XH6uZqzDs652VUyQDGSboHA45sChfkoBpBHcmY0HD4dX
         BcTNnpo3ZR+D+MufhkrZlsTTCZ5aRjeggk2C1FrBIJ0PLq1Eod2jaCiyBO6rLckj1J2B
         H8qYw77wS0ERYS1qGYYua8jN69bbjcCX1Z/NQXKCq/kGmJaTLH6OM4gq6qeoVwuVHcgv
         rL/+f2qNAqgCxVB+JfnnuH4fCb/M6lkDEOsbJZpX8W4SKwcoZmjbGO4o9fvNiZQUWLUf
         Wd/XnfIbvbq08MPnO6uj4EQmisjgQZ+18wlHRC30z6TEVJUTVfzMGPdNSGe7Z3UO9h/S
         SNQw==
X-Forwarded-Encrypted: i=1; AKwUvBzf7+0HfonuPI2n39hr7RGKKimPKNrlkOT2rbRJP2HtcA616uE66B8QIUeu6EJFENQslAw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpRgYkGZC94SsWGYdg9blhNzByjBHg2FYEK2ctHvGU5TtSofNj
	LrEvHaN3Y2dyES+ZY2vvwxLKBMa6b/FYLzEr9QtO08KBCKkXyps7HswoPkKyW0m+u8pF
X-Gm-Gg: AYBFou3zJuAs4jEXcrVc7YvnCZrLNn/wzTvhbMDTIbUWoQ+Yct4ocL8MWe7T81aFVbQ
	0h6b5wAnIS3+obsnXqxjBc1cZgib9WLgSx46+2eN6UL/tE35DuPCtfAOxByZdnILshk/RZFSj7R
	SQaQJoa0mCRrYQyW0VfNCTdLS+aFIVEkqEzDPFOvBdDTUwLpJpBDnpVGxedb8htFqcnPwg/wC/B
	CAJJNSbRZ+BU10MSaeDC4X4+Kbk3QnSCTz+e/AGTcCPCdRxzH9GyeZZ3t/gCPux1UDxBrD7dd0w
	AbdrimhEWX9sVzdcDcysTgRamRT0F1HiM40Vu/y0coMivgxQ1u2f7ICsOmhR6LMVSPPR2kyGcce
	pqv7PnEUMLbhnn6eBrEjGWFQ5YAs9kBlCDc/EPHud2+RKMKZzFBxIiIloy49XPUL6KJYoq6s9l4
	H54WXjBhX/nV1dJsIzN3yzRYYFlnQLJY4Geo7uZwImkIU/PfRFiWyXu9BISrdfCZtoDjWsl2IIi
	m1njCPdlCoGYMYSYK7FtcXgjx3vQY6IKNP23xITogehJ4B6mCznAg==
X-Received: by 2002:a05:690e:4881:10b0:677:ed83:7ef2 with SMTP id 956f58d0204a3-679362620bemr51250d50.72.1791496645626;
        Thu, 08 Oct 2026 14:57:25 -0700 (PDT)
Received: from toolbx (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679356ef60fsm121969d50.21.2026.10.08.14.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:57:25 -0700 (PDT)
Date: Thu, 8 Oct 2026 16:57:22 -0500
From: Andrew Halaney <andrew@amutable.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, bmarzins@redhat.com, 
	dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, ebiggers@kernel.org, tytso@mit.edu, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, fsverity@lists.linux.dev, linux-doc@vger.kernel.org, 
	brauner@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 1/3] keys: add KEY_SPEC_DM_VERITY_KEYRING
Message-ID: <asgQxTE-6YtEgvYZ@toolbx>
References: <20261008-ajhalaney-dmverity-key-identifier-v2-1-008456d189cb@amutable.com>
 <910460850fd4163dadb804fbdf6c17f6a9dfec060f4d865a17df87336ea3e165@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910460850fd4163dadb804fbdf6c17f6a9dfec060f4d865a17df87336ea3e165@mail.kernel.org>

On Thu, Oct 08, 2026 at 09:44:46PM +0000, bot+bpf-ci@kernel.org wrote:
> > keys: add KEY_SPEC_DM_VERITY_KEYRING
> 
> TL;DR: Design/uapi question: was David Howells' v1 suggestion (reserved
> negative key ID block, common register functions) intentionally dropped? The
> new uapi value -10 should be settled before release.
> 
> > diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
> > --- a/include/uapi/linux/keyctl.h
> > +++ b/include/uapi/linux/keyctl.h
> > @@ -25,6 +25,7 @@
> >  #define KEY_SPEC_REQKEY_AUTH_KEY	-7	/* - key ID for assumed request_key auth key */
> >  #define KEY_SPEC_REQUESTOR_KEYRING	-8	/* - key ID for request_key() dest keyring */
> >  #define KEY_SPEC_BPF_KEYRING		-9	/* - key ID for the BPF-specific keyring */
> > +#define KEY_SPEC_DM_VERITY_KEYRING	-10	/* - key ID for the .dm-verity keyring */
> 
> On v1, David Howells wrote:
> 
>   I have no particular objection to setting aside a block of negative key
>   IDs for special keyrings that need to be accessed a lot - though I would
>   make common reg/unreg functions that take the ID to be registered and,
>   say, set the block at -257..-512.  Moving the BFP keyring to -257 and
>   DM to -258.
> 
>   (<715249.1789718726@warthog.procyon.org.uk>)
> 
> The question of whether this was being asked for v2 was raised in reply, but
> there was no answer, and this version still continues the one-off -9/-10
> sequence with a dm-verity specific key_register_dm_verity_keyring() and
> dm_verity_keyring_lock.
> 
> Was the suggestion to use a reserved ID block with common register and
> unregister functions intentionally dropped, or should it still be addressed?
> 
> Since KEY_SPEC_DM_VERITY_KEYRING is a UAPI value, would it be possible to
> settle this before the -10 value is released?
> 

With the BPF keyring ID already being merged here in bpf-next, plus
Jarkko's feedback/RB, I continued following the current pattern instead of
walking back the BPF keyring ID, and dealing with the
builtin/module/rodata differences I alluded to that would make that
approach a little more annoying (at least with how I thought it thru).

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37844805282

