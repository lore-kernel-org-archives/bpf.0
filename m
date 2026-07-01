Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1F48097B
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910335; cv=none; b=KT6D7eZtmpLcEPKIRy9Qqf3mQZuwYWhuYn3DlmLeMI/Yr0gPTgEQZNjqdx57925Ma3BZOlyJmK4yTzqx1YFhAYcVVKx80ycIiL2FZuJ3nRbC+xz1eO/XtVoN7DrAKcFI16EUkV2onPcBasEbFb2pyX7UGAQiDVahFHTTg8+09sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910335; c=relaxed/simple;
	bh=BTxdh5Md4jN0jz0/EPLsTIHwavSFz+o4g37ScCPnc78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1tf0gADD0tu6LCmyl28Ldgg8Y7er1TZpFEeShR6eDQcreYox1BuNDZV0vSw188Zuw2aLN1jj1SR0ZxBcAGumja2xifTcQF0npRJLHtUM3aEpkplpqJmpcdnM2A6se7x5jEBgziLZ8jOh3CWYQONw8gdrogbkI/5pGmS8zA79rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC7VMtCr; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC7VMtCr"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81062fdeaf5so18783587b3.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 05:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782910333; x=1783515133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KRa8dFyzV2cMAE0LM92Xv2fevBdHI3119BxUOXFBzuQ=;
        b=bC7VMtCr8/2507aMhR4dtgz72pvM9eVkOpxunMCdK/jyC4Xq25OoWBUXPAHL9D8ilv
         51HSvwEZ9Px6mZ+ScdbJ6UPyiwvvH7jXot7uYbBHi/b7n7VzmEgXu0uMX1Ex7FnOdtv8
         JEVvlVNqz6GCen38JQI31Q2YQz0vIi7qkzdWz0/MHVIJj/28fpuAEcTJ8/54rbtQlMoN
         NhJio3GBTCrnipjQ2PS3h1BST1PU8f0k72Jtk7WyXU8HfSc5TZNYAtA+To6C4W3UmUK+
         m5BwaNzMcwWkUtTDizpEu6AMxpLB+c53Fvm4z2makUovuIHoQeqzx+j4M0PQqqD2vvLt
         SC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910333; x=1783515133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRa8dFyzV2cMAE0LM92Xv2fevBdHI3119BxUOXFBzuQ=;
        b=UN725PqjRSQPBS2Vi9o/hJLzssOX7YlsHWBhXpU6j3y+X8OLXxLqWyUg/Q52naM6Jg
         SfTPFGL8uTvYv7rkkWdv62XEpBSiRBiXwELVlMNbCQu+upjN/mCjOrUUzCo6U0H36YbN
         blFsPxNFseNDaysc8UmyvYF4R3piwyZmyFcODdBlthBzwMsYKY8/XpeHMApP7z2aye2D
         6kZvVEshLmU8lVaRSm7DJrU+fK5Pl6uvEFsERKm9ycZjSTTEhWyLBncRaRrvV3NqNY+G
         qyRxo0epteWBB0lNXbyeLdItHT7zw++K6/33rPxQD/3iQztGe+EBJNAC5/CReyWB2keL
         I5zQ==
X-Forwarded-Encrypted: i=1; AHgh+RpWwOaSI7z3yMVUDxnKT6QGRG0fAhv2N4lE8l7fdajUgHkHN8OBxIxTY0/UQeMAceWuvgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5yX7wOcTM/fg8D8cvHLaH2jzKHXU8qYuVqQY0FnhHIvBWmqBC
	22l1jlLnjz3r3dkq1uB1NnMVxREcrDSwNP1uGNznO1szIjQqi8OQ6y8H
X-Gm-Gg: AfdE7cnWHzD0+IRBAUknnzWHsdIhq3/i8lTFHE9LfdCpVH8CKUDygvgp2SL4cl7rUXY
	d7BAcQ0/Gn1vel6gxAcN2elbVoRrDU7m8g1gjbNeSTTeXkAhqaT1FS3tXTIju7YSYZtqAenQKz9
	om9iRYqIcywam7RGtUntBJofe7nkQv6kj/pe+T2KgTLOpBiRLJBQCJ+BHQg8AXDHVGscuREVNsU
	tPlqZNTltW5u7tLFRQdDaL647H4+aA80npyjTKVopCcK9b1RFpb7TPPs5OXiO4RGq+PcrARmv67
	/oaTCEPyvGuPpaXSwE1kykMYOc9xCtGrL48Ei2i5lQRxm4ulgwV3CneGv8rzhAJVy9/RN6aBZLh
	GZsaaoPijlWBMDDafTbDAFLms5ZSDule8MK1Td3jCixpX8GhT6Md+pvVqUgfh5sPIu+8Z4m+Ynz
	kMalt0x2sYhKEfc4sjCv9afCk6RRPAKq7wktpRDGDIOKFwsws=
X-Received: by 2002:a05:690c:92:b0:7ef:e7ec:b6e7 with SMTP id 00721157ae682-8118107cb17mr55744057b3.27.1782910332829;
        Wed, 01 Jul 2026 05:52:12 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:60e4:f1cd:c4d2:6ac9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8128ad331d7sm7358117b3.15.2026.07.01.05.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:52:12 -0700 (PDT)
Date: Wed, 1 Jul 2026 08:52:11 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	jmorris@namei.org, serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com, 
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
Message-ID: <akUH13qbsEnJLgQu@zenbox>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com>
 <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>

On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> On Wed, Jul 1, 2026 at 6:59 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > Create 2 kfuncs exposing control over Landlock functionality to BPF
> > > callers. Export an opaque struct bpf_landlock_ruleset preventing callers
> > > from accessing unstable internal Landlock fields.
> 
> Generally speaking we don't want to provide APIs, either in-kernel or
> at the userspace/kernel boundary, that are specific to a single LSM,
> see the LSM syscalls or the security_current_getlsmprop_subj()
> function as examples.
>

I would raise bpf_ima_file_hash, bpf_ima_inode_hash, as examples of
clear precedence for this. (BPF calling into specific LSM)

Is this also discouraged now?

These IMA BPF functions are also helpers, which are more "permanent"
than the kfuncs like this patch proposes.

Kfuncs are explicitly marked as not being an ABI, and are more
flexible for later changes / deprecation etc. [1]

That was partially why I proposed this as a kfunc, and not a helper.

[1] : https://docs.ebpf.io/linux/concepts/kfuncs/

> Yes, Landlock does have its own syscalls, but those are
> "grandfathered" and not something I want to see emulated across other
> LSMs.  If a BPF program wants to interact with a LSM, it should go
> through a LSM framework API.
>

LSM framework API can mean a lot of things. I assume you are meaning
like a pseudo-filesystem mounted interface that controls LSM? 
Correct me if I'm wrong.

I'm a little unsure how this would work with the BPF model. Generally,
BPF relies on type checking and reference checking. Creating a weakly
typed securityfs / sysfs like interface would be very awkward for BPF to
use. Especially if it requires reading / writing files, or parsing
strings, it would be very hairy. It's the same problem with reading any
file from kernel space, it's almost always inadvisable.

Pseudo-fs is fantastic for userspace, (read and write is as simple as
echo and cat) but not fantastic when you are writing BPF programs.

But maybe this is a false diochotomy, I see no reason why the LSM
framework API couldn't have a strongly typed interface into BPF via
helpers / kfuncs. In that case, wouldn't these kfuncs be exactly that
LSM framework API? And there be some translation layer exposing them to
userspace using BTF type information -> pseudo fs? :)

BTF is not just for BPF!

Justin

> There have been some initial efforts to develop a LSM wide policy API
> for userspace, and while it was put on hold to sort out some namespace
> issues, we could move forward with an in-kernel API now.  We don't
> have strict API stability guarantees for LSM hooks/APIs so we have
> some more freedom to do something now, even if it isn't perfect, and
> refine it at a later date.
> 
> -- 
> paul-moore.com
