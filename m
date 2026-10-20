Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505157;
	b=m3B4hJJPFQhSRWJYnB0pNCuFtF5Yw67i4BgVO6t9SuLNVcfpVibu21D9pjeLgjLWR0Cr
	 GKTZC5IDxWAmMqVuAlNf9ZlDE8e2hbl3/er6tH3sepFejlzKNpOWXG2h+UV9LEcTJa3Dt
	 5GjPqQMe8ZFhxnp3gXeafWlWl25RU5r27NEu9apo1EYKgSMmSXZLa8yJQu3LahrPcDtdu
	 Pn5iRFuaLL/cA8aVqRO7QE/utmJF3PGDjIBY4N1z6dCZU0lN79EWoMv+yar450F8ID7I9
	 rY90JSVoq16okTJkNu6Nf5dYNRTtvDlJMVcmS07a6VibIuld3L753elp7YWnZe3n01w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=LdMIhIlvZTbrlYO+3j4hIx5IHxpdtNc/p0dXdNrCqlg=;
	b=TsOBFO/8uZ+MIYXR6FMIpNOMMKxrcPIgoKTa0pNgihWCKIzPyGtfCyeifn39K4SGmdnB
	 /tEQib/A9vJLXUQW/U0guSMmbkdqbSegdFNCS1ipHbJWFq/wDfs0VWVZuVTUobZCkRrUM
	 0kUoYiFJj8Hha0dE5VnlYYHJfVuunoaHyUP8vGTYoynPshc6easu3mWEKRKW8hm/kU0K4
	 qo8YKe9ErzOIIedc9nhdMOwT9FsaWDXeKg2FILDZ29dZ87kxz/0HS5pQzMHZvfeSBL46x
	 eCqPuDq8HjXG3y9uycA1S9c1I5CPaUtr24S+sXvHOJhRDnCWuOfMALxNZvSNDQltwhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NU6pBVdp;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3001F60A2636
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3001F60A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NU6pBVdp
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6798c4b882eso2559374d50.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792505156; x=1793109956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LdMIhIlvZTbrlYO+3j4hIx5IHxpdtNc/p0dXdNrCqlg=;
        b=NU6pBVdpXdS4zzTYissdBw/MDiiN5o5TlNwj//ZWFnIayDvxx9gDu9+hdW70Te0AMR
         lJOPDNX3EmmlHKf5SjsRkfUSpS3+vwRua3DVosyQsGKHGKo8S+9RGOYoBbLl8ZOPexOA
         xzzglLS59r9xTw+UX43wdSNz+zCsYBznrlPO1wxAJjJ4ycSSJkzbxvTL8dKWPvUT1ygb
         zxmJFdEkKjhoPc+3QVIuFZWAzX+hKcUJT4cDBEGwXNO0XgunVCxvpiHtJFEnynNZm9WC
         9StBMW9IYTJjpXxeP7pcleHsubJyMN/oKAkLJ5fmcxcdypeboIphMuGXqduwxNwTdvi8
         u7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505156; x=1793109956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LdMIhIlvZTbrlYO+3j4hIx5IHxpdtNc/p0dXdNrCqlg=;
        b=mEgwLjv6oMl4mLFimGCQBjyusjLsHOx5aI2JL+fe0UqiGFqwX4ogVwTbT5gcLh3wyi
         5pGHtrUxwZVP+H96ExDD9ev41nn1LbZ8kAcuUV2KBN77GT8VyMxUCQR8KKS08E5hFlBM
         9xkYaoojssUYGwwekyZvpPf/ptuo27V5HpKjdupI2LR7iBWcDAb+0Ib1KX4XsPf8OZY4
         LCUQWk/t89LMKKRWJj3W0y/SmGaAoP2AgiRPtlh9U4onpBUoYwCg+Fdd4pRkn047Zfrr
         2B3WljjljrNWEDM1FtVQN5VecmXAXMKfmJABrW/SZFGtBkqy6RYqZBGlhJOTXQLFLOw5
         R1mw==
X-Forwarded-Encrypted: i=1; AKwUvByvIr4oeasU6ke4++P2ZykkYnMnJbqrYHWu+faFa3fUsndeGexBMynHRXfezakiK+vK9wM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqdT8y93PEoNv6/2WA7LsWrOfUuPhrmqzCOIVJ2iXHLUqQeRll
	aYAvPhM3OdV948VADdr1CxB4u1JS9gmFnU506R7wY/hhXBDsYpU1h+HC
X-Gm-Gg: AYBFou2HK0ZruWXcefzC2dPfD80XZHHs2x2VKzJPIP1Pts5Ns82omVt6PhMCau+iEM3
	UbLaY2VZTvmLK/BdVwLCSSqB4PxAw8iwZijuwMHhOJpNjwDSzbckBchVk1GtZuCjO4+CxcellDZ
	fNBSFu2p9F4Mii57m4INVvBdh/KuoUDqG7OOL21y9C8mVp0tWv8Za5dGf95i10T+e1mrqAZE15B
	10uNgji/jWX/kP9h2YcSU5/kXGdZdfPNraInfg+m0W20jnuqx7mMU6v4HKS6ioYeBGG4qamt5uP
	D8TtQxUqdLZ7CpfoTcoHdeSvuiCdx4Q+goKIqqnLUWF5T2Wgnxi1OIjU9UO+5p4a7/UteDG7q1M
	ScnVMJtdgZP5iRF6NaXoOhJ+kw+dcWNnXG8kdv2/OEbWW45bPqTPjvV+/2U1Or2e1xK6O8guQeT
	KMUgRLEaqT3Rh0aCwHq9Zep1rFS3+A6805iALXfvLLWvTYP2jTw6ZdQf2hE9uFfF4bQoQdWVA=
X-Received: by 2002:a05:690e:1443:b0:679:aeed:8900 with SMTP id 956f58d0204a3-679ca7343eamr4757054d50.22.1792505156161;
        Tue, 20 Oct 2026 07:05:56 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8701:205:573e:17eb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1c94c25sm5269200d50.3.2026.10.20.07.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:05:55 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:05:54 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH bpf-next v1 00/11] fs: unified VFS ancestor walk for
 Landlock and BPF
Message-ID: <atdw4wVVarvwgRH0@zenbox>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <DM6PICFFAU5Z.14KOZT5YJO7MA@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PICFFAU5Z.14KOZT5YJO7MA@gmail.com>

On Sat, Oct 17, 2026 at 01:02:40AM +0000, Alexei Starovoitov wrote:
> On Tue, Oct 13, 2026 at 12:47 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > The structure is unchanged from the RFC [2]: a stepwise engine private
> > to namei.c, a callback front-end for in-kernel callers (Landlock
> > is converted, fixing the follow_up() race Al reported, hence the
> > Fixes: tag on patch 3), and open-coded BPF iterators over the engine in
> > referenced and rcu flavors, with bpf_path_ancestors_legitimize()
> > escalating from the latter to the former mid-walk.  Patch 1 is carried
> > from Song's series.  See the RFC cover for the full background and API
> > listing.
> 
> Song's series stopped at
> "It is a conceptual dead-end to expose these two modes via separate APIs
> and leak this implementation detail into non-core code. It will not
> happen as far as I'm concerned."
> VFS_WALK_RCU, -ECHILD to the caller, two bpf iterators and the
> legitimize kfunc are that leak.
Following up on this, plan is I'll submit v2 of the verifier fixes
series and get that finished first.

Then after that I'll do a redesign around a single iterator
implementation that decides the walk type and abstracts away the details.
It will be KF_RCU_PROTECTED and callers will need to break out of the
loop to do sleepable work. They'll be able to acquire the path
references with a kfunc to take them out of the loop.

That drops the __uninit iterator changes and the legitimize kfunc as
well.

> Landlock still passes flags == 0, so nothing in the kernel walks in
> rcu mode.
Mickaël would you be interested in the hybrid walk conversion as part
of this series? Or prefer sleepable walk be retained for now and
converted later?

Justin
> Patches 1-3 fix a real race and don't need bpf.
> Send them to Christian, Al and Mickael on their own.
> 
> > Verifier fixes propagating the RCU-ness to trusted fields can be done,
> > but it's best as a separate series where the idea can be examined more
> > closely.  Then marking the dentry as trusted will allow you to use the
> > dentry xattr kfuncs.  Nothing in this series strictly depends on having
> > a trusted dentry, nor will marking it trusted require changes in this
> > API.  See my follow up [4].
> 
> Then what can a prog do with a position?
> pos->dentry is untrusted now.
> Marking it trusted will require changes.
> d = pos->dentry is not linked to pos. It will stay trusted after
> bpf_path_put(pos).
> pos of the rcu iterator points into bpf stack.
> MEM_RCU propagation fixes neither.
> What next() should return depends on how the verifier tracks it.
> Let's do the verifier part first.
> 
> pw-bot: cr
