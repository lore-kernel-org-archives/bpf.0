Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792689554;
	b=jo7/rjE9JVFsSXM4NFisUf+Pri/xzqqN7kC/0/eKwkqpsUOCcHjQmSSgduhVmMgOHQmP
	 pWKd28hmjNuQRwviinatoaAYjNu7LLj5SQcN482y4HEiajdWaup9Xc3UgWr5NkOFQffiA
	 jmGEwtF4c4lAHFV/uD6diG9p0Tde9xbtEUUQRkH0nyjjBAp6hEQhXylN6CV5l6QUnHq4o
	 ShRitCSQWla3SL74droTyBc7YicE4sPCvWwt2sq2DgyST+Me3whVPRAKMHBN/JGUuqBtu
	 btfvLL5LF3m+IlZdlOS0lba2x37vyqc9IjWDEGa8uvPdA9hLsge8buxjUxRNqeX5uEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BB37ifua8Sxb2GAG5iG+mcuA1PmZC21b7zD8v0nAGJ4=;
	b=OAqjQj/AiLsosGzrh35T9SaBOhEd0wG7xR9XT8wntMsZvyClD8tgQsk7myrp9dCYilqP
	 fUxa+A5+RiIW4jGpScsFA+G6YxUOebUK4IcofGOqkUzkklZxrQ7/+4AMqwQo9zagM3kTn
	 pOj6pmkw4aQWw9nbKMu+5BeDjbGeGBvltgdrZP35vZYoMX5fYxOB6f5DYyY6YZq7bkYem
	 i+t+r/adnD6lCJNXOF7MgmLBPbFFFyXHdEpGI/g66o6cH1FGc0HyB4D20Der/xC1lzDYs
	 /Z0kJ0YyLjOWM2xMi+z+SrnAe7C9YC6GXDuiwZzxNh7hSssttfzit8ccxl1Eiu4Vw0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="K1eIq/GM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB7606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FBB7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=K1eIq/GM
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so689201a91.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 10:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792689553; cv=none;
        d=google.com; s=arc-20260327;
        b=qAlKTLMNaCa14j0n3eIxEnKm7lLuzhfhqvX4avlsJh1OoW49drHxrKBbxGrqnAUR15
         zkuMjn3r+oDM/vd9f5upRnrMcBH6hKHt25t55F8KddzYcuWBOsGB78NUAgOT9oC3ELah
         3ElHDacYeNsBlZ5qRMHTN3HVznT7dz6RbgrI07UVuaIhcUmP4XS2XbQ4nCAvhuNaittj
         Nn0lVcPvwPIv34Et/O/M0XTEKzpCvcpOFFTbicNFzMDIWWmoohxxzMaYkchmGXepx31F
         s+OZUnXMzvsh+udwr9IienvvJnecfLgyBu3+y5DgK/uGG4zWSEZp64WACkFxDWo2TdPQ
         21tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BB37ifua8Sxb2GAG5iG+mcuA1PmZC21b7zD8v0nAGJ4=;
        fh=7xcbBxuCk5DRAg+j6Onfv+kAI7TGArVwLjmXo+jJLkQ=;
        b=JSU5pP6AKUOl7auD0jc5FrAEGOjRA6j7Co38gvRvhKgEb/B1eKRXoUVvOvXMdje1Bp
         RcLcaIZfrDN7j+IWHbpUxkzfAfvWQQRbjIFjVcsfDqKVXp2XkXzflaMB+WyRE+eUXkcX
         aNairsO8vjg/xkP/5wuEWWvqVXLNhZZTZCvqDmkiwla30jZz9x436ZcJBcG41fDfKJ5l
         M83YVYW0dG7UFIaSDTR/r85de0Lb5/3O8hM2u/9fd7CB8RUOwFwTCQTzRwZSJlMK9ELm
         3JbdjxAwhqKVQRKwq1jq2Uag8nuqhDR2BSGyYvcbijUiHu8RKqCmSkIRKu0g2pqO7Dzq
         CcIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792689553; x=1793294353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BB37ifua8Sxb2GAG5iG+mcuA1PmZC21b7zD8v0nAGJ4=;
        b=K1eIq/GMjRwymTiDRmvQUK4W8vEF3J66M/qREU4Pf5Dgs5jQY47GYeuFACctzhxRMp
         JVIwSc1p02bUGb7HGwOYlEo5uZFib/eQJhSVsSgYR7CG9iocSGXDcq05KcghSCfYpgwy
         tSFcUsS2z/n7aHILMoQ1mkvzB+iyUr4GqW8+qaZVoW1HBBwoVccXepzOQGzfx8z+oMaH
         MbnLhZnhS7e1RtF7WDLLDAdCPSOMm7nw6oq6jiVMYt2JckrcBnH+P1DSoy230ddk83Y9
         MOjI5cf98eAf0w7/SJq4HQ1j/7yH97UuyWDx6nIWaLQ0m7oBxCg7jZCwsTT1NW/Pj+VT
         1VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689553; x=1793294353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BB37ifua8Sxb2GAG5iG+mcuA1PmZC21b7zD8v0nAGJ4=;
        b=od7Yr1iHT/mzmXu9LrhDpFSWfHBtQuv+hUt+YaLQBs6wipKkKVI6HYJ2G92zFY20vs
         6ZjmOUlyT9jgOTXNBQhg7MlZMdsFJBQpVGRATEbFS/wY92fghc0gOnx5PpF/1WuOq3bk
         2rj0+oCO1RGBvyJDx8gIzXdW9tiUdB4eUBhKOmRzMapr2EF9XtYk5BxVDCKo5Jz4TUPe
         Z7U05nASoe8OsS51GX61zXjIYJO05bRpiIwD9rKImn8Cn8ypL2Mma8hxXmlxK6NqsvoX
         SVrWuuR9u3yw3g1ffXnY6aQ/jPa40kNRXJS53R36qlepVfK/JbND5+OFeWsTqzQnuRKx
         sf8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwBy4iRfA8YgT95sCbWAL0m7TrHud7jAoIH1hWavWMzCEVDFGRWP90jyBCl6tGvPMjkJLU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKK2tK9znISxi+h1tGjk8QrPzWzeoNPD2LWrw7eq7j1mkNNN8P5
	/kT6br67+Q0uNTK2BcL9fFl6w23qm/K66e88FnoRjEILTLQkNPQIILQEan5avxfLPINWy/y8KIh
	RMeeeKthsnY9iyvA6aCsfvPuAkI4VylTPub1koj0k
X-Gm-Gg: AYBFou1Fi3S1d5XK3+I6iU+ioAnyeoCsgjJ9wFyg+7f7uIukcRM0csLMebuYcPHGYST
	fVQWPAFSj6t+SnAuXlVA0RzKdrmx1tuTEQdLtwDMPoD9o+eSJPX88J2GCY2GXNsndoXd2P5mSoA
	hcpagZlbQqaNB/WlWVYJPtmSu2I5lUlu+8wXAdc0MHDXBwVj7Bpjo7P6UkQZ9Kb77wXptmlR4F5
	gyrIiZVusfUfY27kOyv25EPHBIlfgQWTFF1UC7nxSF91rWURw4D57eDzLNKwVCDNwf8T59X5IEN
	v1MJe3RbDWtTUP89s73u0zjDkJ/i/4pA7PVTT7oU2ceVy/84SJCM8oiMGLv0+PUTuu2vSmM9xkk
	D8g71cSTnGudD2KJ0m9Zj78IAqtKoEYsKOyXFMqdRv2VvZEpenFXjW10AHzc8i2kJlwTi
X-Received: by 2002:a17:90b:514c:b0:3ac:95d7:2f95 with SMTP id
 98e67ed59e1d1-3ada6d24c14mr2208639a91.20.1792689553067; Thu, 22 Oct 2026
 10:19:13 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com> <20261022-hausbank-dozent-hurtig-9443f3777475@brauner>
In-Reply-To: <20261022-hausbank-dozent-hurtig-9443f3777475@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Oct 2026 13:18:59 -0400
X-Gm-Features: AclHuK_mpvVbVbsjXsFY4C_2Z-Hg3ACXgqMxfwiNaJKHEvEnCJIfbBS66y6uEck
Message-ID: <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: Christian Brauner <brauner@kernel.org>
Cc: Fan Wu <wufan@kernel.org>, Manuel Huber <manuelh@nvidia.com>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 6:19=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, Oct 21, 2026 at 12:51:35PM -0400, Paul Moore wrote:
>

...

> > As far as I'm concerned the decision of how IPE uses an IPE keyring is
> > up to Fan.
>
> This is really not an argument. Manuel posted an RFC that follows two
> existing in-tree keyrings to the letter. Fan asked to deviate from them.
> I explained what that costs.

I felt it was important to show some support for Fan, especially as
your comments came across (at least to me) as particularly harsh.  The
strong reactions in your latest comment only served to underscore my
concern.

> > Of course, fitting in with existing norms is important,
> > but if it causes IPE or existing IPE uses a lot of pain, that can a
> > good reason to diverge from those solutions.
>
> Which pain?

As I said before, (emphasis now added for claification) "... *if* it
causes IPE or existing IPE uses a lot of pain ...".  I intentionally
did not make a claim either way.  Once again, I wanted to provide Fan
some support in case there was an issue and he found himself in a
position where he had to push back to preserve IPE's model.

I think we can all agree that upstream kernel development can be
difficult at times, and not just because of the technical challenges.
Working in the security/ space also carries its own struggles beyond
that.  It has been my experience that having someone stand up and show
support can sometimes help make that a little bit easier.

> > These days everyone is
> > going to implement whatever they please, but if you have
> > needs/requirements about how you want things to behave in LSM land, I
> > think it would be helpful to engage with us before you make a decision
> > and then start pleading with the LSM folks to adopt your approach.
>
> I'm not pleading with anyone.

Perhaps that was not your intent, but that is how I read your "Please
don't start breaking an established pattern that works well." comment.
I believe that is a reasonable interpretation.

> And the engagement you're asking for happened. You just didn't engage:
>
> - You read Daniel's bpf keyring series yourself in August, Cc'd the
>   keyring folks "for obvious reasons", and had nothing to say about
>   the model. The cover letter spelled out in detail that systemd would
>   provision that keyring the same way as .dm-verity.
>
> - On 2026-10-11 Manuel announced in the KEY_SPEC thread that he'd
>   propose a .ipe keyring "modeled after the .dm-verity keyring" after
>   "initial discussions with Fan Wu". You and linux-security-module
>   were on Cc.

... and you are seeing the engagement now.

> As for "everyone is going to implement whatever they please"... In May
> you told the bpf folks that "we just need to be willing to accept that
> we have different needs and show a willingness to accept different
> solutions as a result" [1]. I don't see why that shouldn't apply to
> systemd using BPF LSM.

I'm unclear on your comments above.  Obviously out-of-kernel-tree BPF
LSM code is free to implement whatever it wants within the bounds of
the BPF constraints/APIs, that was the intent behind my "implement
whatever they please" comment.  I guess I could have made it more
clear, but it didn't occur to me that this would be a controversial
statement since it is already happening today ... ?

> Frankly, I couldn't care less whether IPE chooses to model the keyring
> the same way.

That wasn't clear from your earlier comments, especially considering
your tone, but it's good to have that understanding now.

> I'm confused why you have to speak for Fu and why you're so
> defensive about this.

As mentioned above, I wasn't speaking for Fan, I was speaking in
support of Fan ("... the decision of how IPE uses an IPE keyring is up
to Fan.").  Perhaps you didn't intend your comments to be received as
overly harsh, but in my opinion they had the hallmarks of anti-LSM
bullying that I've seen far too much of over the years and I wanted
Fan to know that at least he had my support to make whatever decision
he felt was necessary.

--=20
paul-moore.com
