Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686757;
	b=Z2Ty/o59VEiPEWuxoc5PoAlo7b8AZIIDLGo/luzxnHArRN3jK/vAFXqhT3zFHSIRRoSq
	 EAzgooiwZloXIrgKMsDnKD0P4l/GlLJLYEO00cF9O4s9+zIUqIaCof9aQDD+KB0Tt8W+t
	 aB5+Qw94dyoH3blGYdt0kEjX6lcq0NNVJXzvTYzw5fK7nOh65RtUycSl1+t6H7aeK/oYH
	 Xe7vF8qgE2zh/9fb/uKRAlYG6iBKMC6mxbmsFyewftG42w6eJ+zM3mH0lzBm4oURds0xF
	 G5kea0tHRfube9rkf7fXrUrNwO/6cDtYxdxZ+r1fLLh8Pl0w2Y5b4fFRAe3+oZuZbnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
	b=zAyhg5Xu0wZvb0qTu2ClqEXj+EHx17U7+J5LVEC2vbHtV1amvRHo257db3nD3fAByfhO
	 42HnlvRJHPwrKfuTPsUHSHpBpv/bx9ZaAGz+Fn0bd9VYW4VcVYQnqcRxYue6bT+LnRY4X
	 4vi9p7SzgqCfPfUU9JtM/mKh+VCAdLrkyITNpMfKEZPECdczBO7oH2T//yVIETTDayCwN
	 c5BkRGvw4yBDXHGNlelFXlCp4Rl/YVUHorznFkexkpxX11H+EkF4uEPe84z/CaKl7+TQX
	 F3SmPZhBijRNAGcnzoRScf4Ol/gCRxf31uk6v8NRnXsoeq0qvSEg3eka8hl7o0nMaLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D8606A329
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 20:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C6D8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so1463750b3a.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686756; x=1795291556; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=ZNpsvJMizOoFFuviUq3R3I7xBszXKHR6f+dU2Lhp8+AdJOsuucW/Jpjz4DKxOc01P8
         7Bf2gXYBYorSyL2ypHSps7l13uEx7uOW/BQ3oCjgyM7fn4nszFId/ZhifmOhhkUhMak/
         Krv6vg2ZKrT882kZ97nfZeCj+rR5WiJ1p/wW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686756; x=1795291556;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=pNd/fhood02U68C/hRW2C8bjgCyt3bwBRt8BED65ktWG0ZZsd1B4V2FwppzOamRg07
         5LqgUkCGGNOu90adFmBShKJtCA1uYJtZxew6qVakwQd1k4Ukv0mqxEG1fed7KDkNvGkP
         6RK31Qrx8GA5TIGsFmtCHcirL9790KMNiC41SBvrdXYx/0vj/c0LaeE9tBS5Hn0K9Ogd
         LbTfLKPlX+9r/mDx1beU5K5nqSnTxXb/TOy3x+qaCeD7Ho/h/aVfMoCGNn4smMJ0S0cI
         pfmh/SC6RgIAfXdUv2iYZ5nATZGWnR8dmA61ILkzBwvewwSdCHxRC1fToWGw7O92hnHA
         l1yA==
X-Forwarded-Encrypted: i=1; AL+hErFpitcAPxVZdTueAewrqlfgEW6syFtF/zAb6/emWlGiqCVKvZJdVuXo+nw8iP4wpWtxfpg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bnPLg3wIKMKtZiUB1Ujg9d36bOYC0aPGCiA84cwNXg/A5qEVH
	S9xgMU+BxEzdNaP0Qw32XhIwZ6K0XrkrPzU+OrvD8JOm5uCMI7lnmmEYoCNMoKx9m7s=
X-Gm-Gg: AYBFou0MyEkQwNGJci6x2lPddeeYOMlz09hNfvQaPa4hm4DUT9ArVREj6fJejA65VH8
	dlGIdmjLV8f3Zmkh5ih13zin7+Pi8Vucj0JzCfdPUvxBSIZ2r375YXTmqWSdK+3LCJDSKf15YbX
	G+c7+j+pgYyRB02XhWOu4lSItv1aMkE6hCv6/r1hG/uVprWpFmYMLcHAulZu5/jq3bi1BtRS8X3
	mXF3drQKONUl9OEczi21fGkYqlOYfRAJpT3gy/8mhtL5ccOyXJiKgh04cHXHNgACO9ROYMrIBfw
	7nBEA+pPWtn9ieGToLhexiaXxLkXuUKUBhSLuXZbt8kHgwtDBk1d4fSyI5IAkI2GnSqRnIYkXLp
	QUrGv/ARIhiKAxkwko4olWIPRGQIUzx/tujrAprl7hDc3cCT0SCch6PLcZ5S1CSrpZsJyS+B6M3
	FYcPAReJPIkYXHsGi86XZ/NnhaIGbkXv3qAnjTO1J9HKQo/iDrbY3ZhNDx4eVdxXdZtWINK9ttq
	wGK0dnY0q7FV/I9OdLw0xImp24/7Ovee27pRvWEkHK3yTqEuYDTzXBPLTdI6+GheL+x2b6UapAb
	NFgMCH52s/QsvMbAijf0z2X3IPYdYSjAWsB14mWq6z+5Ia/Rs5KkRQsc0HAA6uOHCmlWsmG2ODz
	6+UqXNm4GbMgeUAdyQCzyDwndlzvCVYnw4A/KY7lt7NsKnGxcC4dJbPLVB1H/Txe9FEEy2YO5rk
	+E9qH6BqhZWgDexz1X6JOo8rkd+5f8Dl8aFVBtUSGUzDManPyvaJoqbIFt
X-Received: by 2002:a05:6a21:748b:b0:3e3:37ff:3795 with SMTP id adf61e73a8af0-3f7a4dbfbbfmr5517650637.7.1794686756009;
        Sat, 14 Nov 2026 12:05:56 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm2271197b3a.13.2026.11.14.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:54 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:50 -0800
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
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org, Alexander Mikhalitsyn <alex@amutable.com>,
	Breno Leitao <leitao@debian.org>, Casey Schaufler <casey@schaufler-ca.com>,
	Chuck Lever <cel@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v2 00/42] fs: don't use pseudo filesystem files as
	storage
In-Reply-To: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
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
Message-ID: <20261114120550.0c9e73aa12a3072c@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Patches 1-11, 13-16, 18-26, 28, 31, 32, 34-37 and 39-42 look good to me,
so for those please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

I've also tested 5, 6, 34-37, 41 and 42. The selftests all pass with the
series applied, and a uid 0 without capabilities can no longer change
/sys/kernel/reboot/mode through a loop device. So for those, please also
feel free to add:

Tested-by: Chris Down <chris@chrisdown.name>

I've replied separately to 17 and 33.

Thanks!

Chris
