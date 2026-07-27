Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565A43A819
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171072; cv=none; b=hcrIfKffghzTtVqSHTtji6SYHhdgr0r6+vIWN5Jsl+hcHLl0wdz9IW88T8n7W7/k2/qkk65GcVPpy1i9tS1Nj15rxS79/u95oHmJ90EiQYVWrdpgKmsFSdJ4QtsnV4fK06yCICUbDFqo8Smo+seA7ScL8gUcalk6v0Kgp7wo0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171072; c=relaxed/simple;
	bh=dP+w9CgSwbvnICKT89qqNzt182iBYmnd4c7esHRdaqk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=db4oll5C/NMuC3imrvItrFJrqiw8afhpXhHgdbzkd+KM/kTFVQovkoDebQotB4lRZiq8Ku/iU6AHNRkWg03tzRur9NaGnsLXAoaa63WK6TPn0viCQNIC2hbr/oNGNvL1giSEdq7ijJdOF6e55dKVoOLB1OZNCzpCEI8JeTKaBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ra5C/YCq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ra5C/YCq"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf452def93so946585ad.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171071; x=1785775871; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dP+w9CgSwbvnICKT89qqNzt182iBYmnd4c7esHRdaqk=;
        b=ra5C/YCqo4JsVWn5l+0c48RmY+5IptqdaRtjIlgIB4b//jLtIrbhAOmjSq2cjOqo3g
         6X/hn8BVyxCq5WQruji4ssMN62My40RUryZiXgw9tFsG4LV5CzQWnDm7JI2M0Z9MSohA
         Onu0ywNNez4//MNpTlWyA8CRXwxnNovRap57tFVM3htoqJYZNyJ3VP+14ry9et56qGiD
         RmZQ0IixFSREFMUJcUCr7gn8UNzr9rd/I2oPjNXyHZKR6LHQO34Js4krraQpO/8yPOFn
         MsOqPpiFdYC/tWcVD1pZr6w6cxTnLqvpdcLh+mHMweUqIzAS51zdfxmkNnj8JVssF86P
         flYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171071; x=1785775871;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dP+w9CgSwbvnICKT89qqNzt182iBYmnd4c7esHRdaqk=;
        b=myxZ1QTsgTV4F/Mc/tqQEi9z9hZ0+JNVLnzOhMEoK43CzN4MNhzlRC8o5GyLBUTsXv
         P2fVG0G0GV8REwL10voExt7SF7w71tXt3kh3+4PviF2PPuashZBUr5zpsjvHeFtkBQk4
         /Hzfp0kBEg+/5Fqy3Acs0wA7CgkJ+jbnWGGQJFsojXDqE8JRMXzgjCIWa1vw1Vkv0oFb
         fovPc3SdXwhaJwpq90mF6lOAPew7RDfElRPZD8alKgyC0udAXYf1Obe4U5fF1fbtsYu8
         t7R2BjOjXZ8uslMnvVuxuqxEw8KmPYlmnl+ovV8dQDhc9CC7+DlEvmUNCDo4g3kGaODn
         fCMw==
X-Forwarded-Encrypted: i=1; AHgh+RooXjTb1OYytKbL12BRN7g9wzlUJt+SQ5DxHKSrcrsxJcOlhemYZ3dgL3rsab+nXTHFZww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYVk2fVRmiKqLh3RkuyBqn/rdAG3qBJu86KMiVw1ECfDO8xD4
	iMsf1SMhNB5VyBCjnCxlX3Rb9oLrx9C67zFxhz6NYOztEPSv7ZPw32Kv
X-Gm-Gg: AR+sD13zVDv64xunDWgSn6QLwH+24u3Dks9UZmTLxFOms1SxQ/hc8qwh5A2jLh1l4Ep
	Oo3xoeP/qEFvQI58uuxStRTgvvQsE0zeMHvqi4/KfIhjf4YYilwp9H0LjSSc76bSghd5IXbh4n5
	tKKAy58+JJdsl2fwGxYbUSfnyhgfSrsVxufyPn2xf5M/EQFrR7QgeDG83VEjIyMarhs+PpAI3No
	pcyoDMja8nvs1swpX6lEztl4r0/1E/k5CSumKYumbtSxL1sNrYDzrxJuUUTcnzGZNSCEtF5FeZf
	Co0UdpYahfVNf5/K2Dh/l+8P1XkF/k5CUNsdWlTzFx3oTndDpVv7tXyG2ztWtOqLt/S+Z9XAent
	/toqAkHeAEdfp6LoepXoWKf84GJWDPzv3LTAMFcLmcDezPRfPQ8fziV5c6K0ZKp0dTPVSxW63Mj
	BufRnJ8R2hPFXA0zeWBy8Kvqca4HyPiZS9XqObVeDxsPDliMsSjBpQPeXmToFngh9fKBfj7dra7
	y4geKCaa/PKevaH267dAnt725Wa
X-Received: by 2002:a05:6a20:1602:b0:3bf:bbad:500e with SMTP id adf61e73a8af0-3c6c89c589dmr207113637.5.1785171070520;
        Mon, 27 Jul 2026 09:51:10 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66b5ffesm3517078a12.19.2026.07.27.09.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:51:09 -0700 (PDT)
Message-ID: <5a5a12d5309ec799bce8e11d510098df83594257.camel@gmail.com>
Subject: Re: [PATCH] bpf: normalize arg_track state construction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tao Yu <tao1.yu@intel.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 bpf@vger.kernel.org, 	syzbot+0098eed2cc898cdd672f@syzkaller.appspotmail.com
Date: Mon, 27 Jul 2026 09:51:07 -0700
In-Reply-To: <20260727030712.1683158-1-tao1.yu@intel.com>
References: <3274df73849ff8620dfcad063c6af17b10a36982.camel@gmail.com>
	 <20260727030712.1683158-1-tao1.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-27 at 11:07 +0800, Tao Yu wrote:
> Hi Eduard,
>=20
> Thanks for pointing this out.
>=20
> After re-checking the old code, I don't think I can honestly attribute
> the KMSAN report to one specific assignment.
>=20
> The old code did have a few patterns that are undesirable for a
> tagged-union state machine:
> - in-place downgrades such as off_cnt =3D 0;
> - manually assembled temporaries such as resolved in
> =C2=A0 record_load_store_access().
>=20
> However, I could not prove a concrete source-to-sink path from one of
> those assignments to the `m |=3D a.mask` read in `__arg_track_join()`.
>=20
> In particular:
> - the off_cnt =3D 0 downgrades operate on states that are still
> =C2=A0 interpreted as frame-based states in source-level logic, so their
> =C2=A0 causal link to the later .mask read is not proven;
> - the local resolved temporary is indeed only partially materialized,
> =C2=A0 but it does not flow into `__arg_track_join()`.
>=20
> So I think the code change is still reasonable as a state-construction
> normalization for arg_track, but the original changelog overstated the
> proven root-cause mechanism.
>=20
> I've respun the patch as v2, reworded the commit message to describe
> this as normalizing construction of the tagged-union state, and added
> the Reported-by tag requested by syzbot.

Hi Tao,

Sounds good to me, thank you!
