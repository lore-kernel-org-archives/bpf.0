Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDCC2DC357
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776883846; cv=none; b=DHSLiZyH8u2+IIngYhNbYlwx3hBjnXL9QAuUaiZfVQuyPEle0o4VfNHI+P8scWJhBtTYVN9WBoketF9DuqLw4YnlCZfjqtD3L5CsHG3VuXfl9uZuLWeRYW/6Uryiii6DGTtNSoVCVoQ6cJirzIe6yqYzwkiN7wHjiBuRfv79AFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776883846; c=relaxed/simple;
	bh=ic2g+3H1Bjt8Eoenl8C/wnTWLiAcZvj+NJ4io3SQ8Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igQg6O1aD7/nHLiQ2YdxEkiW4rkUIQeM2082FDQHnk8FrduR2cN1ZJLyGSPRyw7KRLSQiZJysztQNF5tnqTjZbhDveAA3BgRfpLjTwM6kSg2kbnVMJO9j/E3C78D6r+pNKIkEE+NcZemjYU5L/pdZre3yEAg7uhDM3r3evHezzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IwYpqDKm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IwYpqDKm"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-793fdbb8d3aso61204127b3.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1776883844; x=1777488644; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NfY2mNb6T4MB2zH44et65lOJxNFCx009tFohO2VhSnE=;
        b=IwYpqDKmG67OEyUOuXSHQ8a+NIVvM+dBOrf9IsGH8Xq9K1F8tZmqXgBJ7KSutUqzYO
         udOwG8n8aojk9T2SE/41dxAjH6sGzozgUceMQpC96Nv9hqmga+lhf7CUSBzDfWDvaPCU
         hkGwGhB5FUM2WUNpot9gmd76sJg5kk9XlOSe5vqitiGFYf0X1kyTlsa9TwGIDgzjGg/5
         9xv/psJozsTIEy9d4CxiygIDjYbcha+oPXr2+icOmdRJg1vr5pa3tGnuAzC2jYhKVTTC
         fdMfL9fjuGfSHeTU98grv5fkO+Ntc9LwHB1eNOJM9w9F5Ey05ELuFDj8HRJ9B0cUWzSH
         pkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776883844; x=1777488644;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfY2mNb6T4MB2zH44et65lOJxNFCx009tFohO2VhSnE=;
        b=S/j2NUh97OzCzbleYRNMv4O0QFPhY+usTqWi8PYCWb9+319np4+oXRjsa9FljeWVdp
         1xGxlOZ0GvR/4myCvFqeXMWwlbftAtbV9ytSZYqv9Qp+avOv5IXMtK1Gqz9y9x0/WToU
         Su1fPxrpCEu/i3Yq20j0RTF70X4Ci+oTpnzj00yg56KQV/aR2BQSHy1IQswItrld2Y6S
         ko9MkHYfu7noIQOkIYoNbLKNOKI4E9lwcDzXqyu2JQhMqwDDAlsMzX8KFGz/xSFsuuYC
         zdDopl8s3CtmK/eZmEWrxis/PB+x7Kg11WCbD/bvZ+jApfXt2Icl8VzQ9DzzQf3/lnoc
         yp3A==
X-Forwarded-Encrypted: i=1; AFNElJ+M784leH4ba/C38G3PfGfFGvLcdpMqrmWnkIBMLR8tsBWLhh9b+zzsMC6Nclf6vg5ADB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/r73SzUnP0RndZaw9fRUKn4IcI5PYTLyppImdbJfSA+tgYHj
	KPr8fAdTRDm9JxdzWPOht+eAWaGig3JUnZgQSIG/sqGXy4+K6qY9883bgRceaYo8vN4=
X-Gm-Gg: AeBDietrPElMDr6Nry5IvKaJzN7YcX5f6859uG051nO0WQptb+/PK046mK0UGfzxbUu
	2+q3fJqOl5DJ1wX2G9IcnyXuqEqkCH9Dg9zy2IJ6eFe5QcUEc09oVtOzu5aLORUv9pyxPPGnp1i
	/s3tmXrwj2iEgfyXxuMaDEFkHQBn1Z8ijwvqFFGK//25VMKxwrk2e/7FFJ5kog00y9qlyuOuqOI
	5eNYL7sHSgpKUDbMshEOLIPPh4ODvWDLdeD39IqETGmHUjF87FOaVnlcEo4kPWMdm+FA/3R07s+
	RcT0g7w8tdCzKPQf3U/SR6GRGL7e9FFC2pEetW2QrqNXhNBOmhAX1zH0dDrnErZlcb+krFTn5Mo
	WJ0MfhlCTDgK9kGOW4Qg2VEAPzgjMxMtDd/uuhXTi/kCL3GbfArOyvLQZ2kJ+nMa6GKnheazwGi
	FgNYj1fIhu6xrC
X-Received: by 2002:a05:690c:7283:b0:79b:e24e:e2f8 with SMTP id 00721157ae682-7b9eccb6dfemr246497157b3.0.1776883844180;
        Wed, 22 Apr 2026 11:50:44 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89abbfsm71419907b3.10.2026.04.22.11.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:50:43 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:50:40 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Eric Paris <eparis@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	audit@vger.kernel.org, bpf <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF
 LSM programs via BPF kfuncs
Message-ID: <aekYgEylSTDBcWK1@CMGLRV3>
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3>
 <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
 <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
 <CAADnVQL33TOWFmxcWod3BCgmMXSQ=cEp6NCcxgQaJL0C7+Z9zA@mail.gmail.com>
 <CAHC9VhSKvC+p5j5Pe1YKB-=vRkRA81K3kp97Q6-H5K+kvYa0AQ@mail.gmail.com>
 <CAADnVQJBOk8w89kj95M3GH-eFdC7njZt=zMEU=skB-DTb3k-bw@mail.gmail.com>
 <CAHC9VhT0poHt_9P407tr3ihfMGJYH0d9=PKxW0sk7gYF8fD5Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT0poHt_9P407tr3ihfMGJYH0d9=PKxW0sk7gYF8fD5Lg@mail.gmail.com>

Hi Alexei & Paul,

Thanks for the comments. I did not mean for the talk announcement to
end in this state.

I understood the RFC was NACK'd, but I thought having a talk at LSS
could open up for some additional discussion around what can be done
with audit to make it more BPF friendly. I apologize.

My assumption is that the committee would've denied the talk if there
wasn't _some_ interest here. And still intend to give it unless
committee decides to revoke it, because there is always opportunity
to improve subsystems.

On Wed, Apr 22, 2026 at 10:33:27AM -0400, Paul Moore wrote:
> On Tue, Apr 21, 2026 at 7:08 PM Alexei Starovoitov
> > Every time somebody adds a kfunc it breaks safety, because
> > people don't read or don't understand Documentation/bpf/kfuncs.rst.
> > kfuncs are not export_symbol.
> > Object ownership model needs to be thought through.
> > Calling context needs to be analyzed and so on.
> > Just because something "works for me" it doesn't mean
> > that it's safe.

I interpreted this comment as more broadly applied to patch
submissions in general, and not this patch series itself (necessarily).

I do think that "... it breaks saftey ... kfuncs are not export_symbol"
is what the crux here is. I argue that that Documentation/bpf/kfuncs.rst
should be improved if this is a common trap that I and others fall in.

As I understood kfuncs, the point is to move away from BPF helpers so
that subsystems can have a export_symbol of sorts.

To quote:

	BPF Kernel Functions or more commonly known as kfuncs are functions
	in the Linux kernel which are exposed for use by BPF programs
	Unlike normal BPF helpers, kfuncs do not have a stable interface
	and can change from one kernel release to another.
	...

As Paul mentioned, there are examples of the export_symbols use case, and
even one whose sole purpose is to crash the kernel: crash_kexec()[1]
And to be clear, I don't think that is a bad or uneeded patch. I just find it
interesting and unexpected that it was applied.

Maybe this series is the straw that breaks the camel's back?

> 
> Unfortunately that isn't the review you provided Fred in this thread.
> There were no comments about object ownership, calling context,
> safety, etc., only a dismissive comment telling Fred to use something
> else for logging.  If you want to provide proper feedback, something
> along the lines of Kumar's constructive review, I think Fred would
> welcome that.
> 

Agreed. I can work with addressing calling context and object ownership
concerns. I thought I addressed these, but I'd like to know if there's
something I didn't consider.

Best,
Fred

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=133790596406ce2658f0864eb7eac64987c2b12f
