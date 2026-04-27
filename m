Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9F37CD50
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325981; cv=none; b=mIokAJdN5iFMWmDSfIoFt6osxLLZvIZJxCy02nhZt8vD3is0f5Gg8oYEbKTuovoLGO/XtheXKA1qw0YA6GIy2RO41W/bbT85XeMxVspQG49aA/g+aXBtp2s3htGgTQRNbCvcMYeiB1OO19/cTMCil9LbWcrI60PhsKNAtKj7tzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325981; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zxo8SDobKcoz9jrymzADe68YyqtuH4CKzPQsKQbKee+c2KUpeFmarNCo2YlgKN8WuU//n1WAAmvICaloB6+r9KkfcvCnWe0VQXlCfENyobtpRsfDpDwtSFQw7DZ3YUJcgyjtQNMPdqQTndyesWR+12q8O4gbUqYlJItWKRkH+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YFh2JxOq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YFh2JxOq"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so236176766b.1
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777325978; x=1777930778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=YFh2JxOqJ//ggC9CWdywHAJ9A0NX/NgsQ7R2jTkQJNVXD/6CHxytfyCPfwF8+MTdVb
         juGCSpNMS/sGvVOWkHxsPXpajalDGaurh2iBAxawcWAiAb1DmP1rnKLNwemAooYsPXu9
         qQasAr4UW7MERJzN0kKhw7kbXZp49fe/kXoyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325978; x=1777930778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=UkHqv1apkfUOfjLlrvJ9XchvaCDh9HK1hqa6Z0Cr14hxPtjyVXxeoAgOnN+j/EWSNj
         Z5aXwcnxpluwPc3QGcM3QSQmUsxqZIeKtYJK6Nv0r5fqO9a4YYKp8ACxyjCstMo81+DE
         vl9K7BO4kTDrXjDhREhjXTBYDs1bxoZwUFkJkF8BG+ybIFq3pm7fy8w3Qug27Toxh+5t
         nPJs78tLXLmQGf/SoGg1KL2SnPSV9PqGNrtvyy+WdipLWmk0Rnoz/jxGGpqMcW2LRxB3
         ZQN5aovZunsMvmws+HFqOXPan9zAdmZVkYYpd7pIoHZz3KIF0VY+VjgxJMiG73UM8WjA
         1Vpw==
X-Forwarded-Encrypted: i=1; AFNElJ9GOcB9lPtIdJdnr+N0WgIABAg4ZNHBnxtrHfVQ8xg5odP5L6AYUkCayUBGWjoRnlrheUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTLCx2KKEdlqb/0B/S60zS5lFouPT7bRSS62hd5cQjB4zoaOX+
	ad3I0GvzeIpXOZJA+3gP5yEzqrSGTo7zbZSBwgd/omgWI9E3revVFliPiZMKh1bGYNg5yAVfLiN
	5+yFACQGilA==
X-Gm-Gg: AeBDiesWcVf9HZWuqiARTHOeOscpAyMMvQP4o/1h76YTKe3hARsiao8fbQkHagrzwzG
	XarfmKeOjdQsBnBRmCWuf20xeOytOcIrVWJtUIcJazw8kpvV4rZQU25wnh6gNXqFGm8bA9liPkR
	8gVB/a0AeQmhgnJYONAj9Hvt+rtlQB1VUUC4B+MGoLDgS4/8HA/ADztkBscpgEuKudLVFQH6bm/
	L2V1pmI80XSWQYfJ9KYCpL8Dlfmf+ZQB4P4M1KkRKy9HQKa3kGeLyAMbHMFQO/khYWHo/y1xtov
	M6NaHB9r02L5E/CgdEF8lC7nATnwODYu5EhdB2Y2SGhj+X04z0oe0RVRvv+K4IuxmJDVvKMBUi6
	9u6w7M53swmqh2FmxavTseQeopHOowddd1p5CzoowlkukkYJea6oZvihojwFrjIGxEiwZje+jHZ
	ieOrGa2Pr6NL3WppP3xCm5w5sKl+/x1LhJvziaaEDbVYrqTmXcypoz9ShZi827VHwm3St9zhH2n
	cKg37S4pks=
X-Received: by 2002:a17:907:d303:b0:baa:65b:fe43 with SMTP id a640c23a62f3a-bb804c33104mr26526766b.38.1777325978278;
        Mon, 27 Apr 2026 14:39:38 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b2aded9sm8979466b.41.2026.04.27.14.39.37
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so18821362a12.2
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+MESWpgb5znjd1X3oQcefQPXF2JrkGAWNzWQXx5Gpwa8G8HKoMCD5TDzXvVgz0LtBawFs=@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
