Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BDE443307
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387025; cv=none; b=qW59TW0S5VeH/FRv6hITSCP0k/qYDhRjkDKTv3cOkcPBEC90ciO6vWb/acwBRGa8vqeNavAvDh7BYbPCymcMa1fVU6LGS8z/sF3Npu5vVnxOwRSM9LR+uQ7Zr88JyZIAbj69GyuZKdTuIuzaHBDPy3H3Jafopx/QZEtUkHQFSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387025; c=relaxed/simple;
	bh=5kpnZ69rpIeJK7I/vVJI1/Sd58TTWJsQUlkCNqKOhyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1REMHOuREF3XbwbNWEHOMvLa8VNl1XrC3E6+jBXkbF6RqSRUxBazVGlSIY9wc7ODFuHp2so6lF9QmUsKg1Qq6GiewVhOOyTqYHL5UFkR5euHQUQd5OFPQp6Hgq0zhjA8vEg9j83tTA3EMEYtGVI2vL3wRzFTX/1YP4hoPALh7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=YnRLPHMi; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="YnRLPHMi"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b056d58f2aso14935117b3.2
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791387019; x=1791991819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fxMsGMJoi15xhCerKdZHKbDFnpM/+Dr7cx060hZaVDo=;
        b=YnRLPHMiCGr5unS/o2c2EHvTVZtDLbNOMEOwpd1emzZ9X7nI/Gocgnbxthvcq+VLnu
         m48QAP1/vPGB9oDTrrKC7Bo+unLlCLwhVA0saPLhPW1jvSP4ewxx2JLky82lJE975xJj
         SCKdzRZDTnb2ISXI9sBkydjuiJhmpwYY1hI3Ey7dgIVXcoRJN+4tgwR3HB0ggPXc4MOa
         9NlCL+H8UUddsFhIjUecIk0R+RAZ8hkEGx4AbJspsUeCI08jOlOBawdMppoeN/t5r5Ur
         3RGfeYp0YyHPy74bXPTdoANsMdK8g5jDlk5C8I3+7FptOoV35TKSO8aDhYI4BtN+aCJg
         67Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791387019; x=1791991819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxMsGMJoi15xhCerKdZHKbDFnpM/+Dr7cx060hZaVDo=;
        b=L1GqqjZSDk0xyBPQ86R+3+pq+2YL2tPy4kgIsNPpTRzAznDNSb02i3Dz+BwrNC06LK
         nvwkczx/Rcjw/C/YakIkWX/XhWuZ8SjbOwSzDJg7hr78u+0oHeOcbBwFBcM+TyLYi4N5
         xPZhL77YcR7Z12ObRNtazXtY+vjDr4Sb8Ngpl7B98W6NmuRc6EEqufrRm5xjfe23B2+k
         V+thkc/KGkHuhBn6D+nHMPlUa1TeUsKGh6UhhWMMnFBJuUo71zVw+Qv/MtItGHEhwg91
         7HfYmLwAKJ6slSmwxQN44u9TuCkMKsfjwasMD+AjbUiCiE3WBHo4yOfGa+oNKSL6+VuD
         r9qg==
X-Forwarded-Encrypted: i=1; AKwUvBy85k5fKLRxFaVKsRmYq3gJmHqD9xyJgfXrRui8+Y2EcCTq0sWjxla7EOg193vYX+rwJMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2iwUZsYEOX68+HDcowoXa6O/oQ5wlG55yVhF8df2H/P3bCLeL
	7Q8iD5/KNi/3wj5eK3a7SDxxErYFs8beWhwigmOiGX/r9VzyQSFVfk46eXQpF8ADXDYR
X-Gm-Gg: AYBFou24rkHuQ0+6ZFoZnbgVaX4cuioEV+r26xi9jZCctINxnJ9sAzzSJjlaBMIAiUQ
	PLnNZ1+lZa4jZK5lOe6rHMkuY04zmnihzbZUtWT+wGUNLirxoqSckzn86c3DYjl4yoKg/F+DiG3
	icMw6XKDEv0ECsTMinpx5MOiSet4RRLrC8Iq/AaoxXNqNrCI4bgML0Wx7QknzDvnGy6UzNHQabR
	t5KPBOD8aM5NCuh0CRCDCgOjMxxzq6AJaI8cS56irFj90cvTXDJ0vVOHoKIxNNElZoW1EoSCcpS
	aQEyztstb5f8gEIEEMSJop+Ak51P46GCfXj1NEYCmc5szs2g/Yurv4q7j+xMjwmffuLSWrhLnAs
	DDJ0Ps0cW840yNIOAWc8CSClWNQNqOB4FAEql9X8xtcaSU73smiJSogDwP57Np0p/rD0EtfTgS1
	aKmjClY6o9BDPmDuWGuSLZR3YIbkIP9VNZ7cLDaqIOgqcnTZ9Rl0qSSdcTTAMUxtZhdSK8vBrXW
	JlHkko/uw6j3Oao1/2IjbAmQlKl+EGDJqFMd9ncv7o=
X-Received: by 2002:a05:690c:6b01:b0:873:5bb2:6c3d with SMTP id 00721157ae682-8b05b14e894mr18727417b3.68.1791387018749;
        Wed, 07 Oct 2026 08:30:18 -0700 (PDT)
Received: from toolbx (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05a9b8806sm9897427b3.1.2026.10.07.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:30:18 -0700 (PDT)
Date: Wed, 7 Oct 2026 10:30:14 -0500
From: Andrew Halaney <andrew@amutable.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-doc@vger.kernel.org, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 1/3] keys: add KEY_SPEC_DM_VERITY_KEYRING
Message-ID: <asZlNEFdvidvMdJ5@toolbx>
References: <aqyiCavj3xeNqyAo@kernel.org>
 <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
 <20260914-ajhalaney-dmverity-key-identifier-v1-1-01922dc1366a@amutable.com>
 <715249.1789718726@warthog.procyon.org.uk>
 <aq2VxlttdlTNlHo6@toolbx>
 <arYzQN1ViuiCBemo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arYzQN1ViuiCBemo@kernel.org>

On Fri, Sep 25, 2026 at 11:39:28AM +0300, Jarkko Sakkinen wrote:
> On Fri, Sep 18, 2026 at 02:59:49PM -0500, Andrew Halaney wrote:
> > On Fri, Sep 18, 2026 at 09:05:26AM +0100, David Howells wrote:
> > > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > 
> > > > This is great for discussion but what we want for the commit message
> > > > is just motivation and resolution.
> > > 
> > > Actually, I think it's useful that Andrew wrote up the issues in the commit
> > > message - and I think it shows part of the motivation.  The 'writing a fake
> > > /proc/keys line in the description' is something I hadn't considered.
> > 
> > I'll defer to what you all want in the message here, I found it valuable
> > but I trend on the side of overly verbose admittedly!
> > 
> > > 
> > > > I don't think we need all this just to say that /proc/keys in a racy
> > > > query mechanism for production, which is an issue for dm-verity, given
> > > > that nothing else is available.
> > > 
> > > I think at some point, we will need a system call to search all for all
> > > accessible keys matching certain criteria by actually walking the key
> > > database.  The problem there is that there may be multiple hits, so we may
> > > need something like:
> > > 
> > > 	int count = find_key(key_serial_t start_id,
> > > 			     const char *type, const char *desc_prefix,
> > > 			     key_serial_t *results, size_t results_size,
> > > 			     unsigned int flags);
> > > 
> > > Allowing you to do:
> > > 
> > > 	key_serial_t dm_key;
> > > 	int n = find_key(0, "keyring", ".dm_verity", &dm_key, 1,
> > > 			 FIND_KEY_EXACT_DESC);
> > > 
> > > This wouldn't be as fast as a direct lookup since it would have to walk the
> > > key tree, doing name comparisons and perm checks on each key of the type.
> > > 
> > > > And secondly special keys are meant for implicit keyrings so isn't
> > > > that all there's to it?
> > > 
> > > I have no particular objection to setting aside a block of negative key IDs
> > > for special keyrings that need to be accessed a lot - though I would make
> > > common reg/unreg functions that take the ID to be registered and, say, set the
> > > block at -257..-512.  Moving the BFP keyring to -257 and DM to -258.
> > 
> > To be clear are you suggesting I do that for v2 here? Happy to make the
> > change and add some reuse to the registration functions, etc. I'm
> > guessing its fine to change the bpf id since its still only in -next?
> > 
> > The only awkward bit with making that more generic is that dm-verity
> > isn't __ro_after_init since its coming from a module possibly, and
> > because of the module usage I also protected it with a spinlock in case
> > someone's accessing it while you unload the module. Could just use one
> > spinlock for the whole generic array, and drop the __ro_after_init I
> > suppose.
> > 
> > Let me know if I'm not following properly!
> 
> I just read David's response and I think he made fair arguments,
> and patches look fine to me.
> 
> David, did you have anything? I could pick these.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 

Gentle ping :)

Are we happy with these to get picked up?

Thanks,
Andrew
