Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1326B1D9663
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791600781; cv=none; b=ENuNoTOMap86J8yusbWgwZNoerBZVdK7JQ9Ny2jUksdfUTNjZa0I3V44cbpcLH/p7HP6lMGCXTkJla3xRz556tn2AysQOda77TPVG04Z6DxansjK6O1LpEQhFRakbzDC5i97p5pVUitZpJuMLLGIbtSZnFzdLqLkGYNVD65bB2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791600781; c=relaxed/simple;
	bh=4Qs8lgaSJwPhckGmxqTCEHOFQ/iOtEbQyOhqJpHAVEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jz8nQZSDIH6MpsHy8LjK2a8DFrXXyLe1qUbeI/hWV1kLiFVH6W9pD2VxlNrPvZ8nXLclbpWl2LpSE/uxuN/EqKKeG6gnJ9HOfadkh+9mKyJg9/989q5+kN1TcBlCxpZYUj6HtKH4vNDyi4VZcc29WfdcIoBBkU3Ekaspp+Y8BeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H93zw6gq; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H93zw6gq"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-141395927feso492257c88.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 19:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791600779; x=1792205579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Qs8lgaSJwPhckGmxqTCEHOFQ/iOtEbQyOhqJpHAVEM=;
        b=H93zw6gqcTT/rOMShwVjoqTE3Cmrj4P62YIoApQbQ450rqRg7nWIrWf7JUoBFL4YPL
         VVeVNsAr3blxFppPR2Sl/ti23sRkOGxl7vuUhIW9/sbECXdPUyrXHQaQXZzPKmQSwgb0
         ciaZbABZTKcMMFwTjnmsb+K8gMgWPUzJFemfKtwHhzX3HChgx+ilQS2QiZ7vgGvfL5KC
         IMmCbYLI+iIjNPnqO3D+o6d9bhZGG3wrBQ5j+BD1Rs9jDb83rwJLi40GeFUmwJTzHELE
         KFL44rTXapsMZK5S2Bb6txkdEcLTmj70Mq7Fh1PFe5hQpv7sOOcqrs/7V27tMcqomSJI
         TqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791600779; x=1792205579;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Qs8lgaSJwPhckGmxqTCEHOFQ/iOtEbQyOhqJpHAVEM=;
        b=YshZIDb0BI90SjWg9mr4CP1HExTiaL7z3uj/wkbPKvyO1F81v+6tCpGCuJKOWod5kp
         NlOb2bfdhL1qGH5UcWv1y6d+m7wDwBTrzJwQpSTEtWLLaaMcu2JQNxiJ+FnQnkJxy+Z0
         BqCAP75BZhw6x5yLNvqfFrUnYbYGYajjNvxvW7XVBu2R5kdG3ejT1UYGdFzv3vm1VRDE
         NLun0MqovGYpfGXYIm5fBupAwqXIM4BhwbnZOyjT6KYBTMaXh27SzGfbw9ZIoLzV2Cfy
         QZExtFWtkNrT3UGkL7QOdnxBh1jlvzxd40ZrHe1+sXgZA4ktlRgDfsv01iSrXz//JwBK
         /K8w==
X-Forwarded-Encrypted: i=1; AKwUvBwWzl5SflKrgIuxm9Oyp+ltBINj9jSFoi59EIcrkxZ02dyQ9ij9phzQOfNWFrfTpqOhWfo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJU1Vbt8rLxbA4KH5xe0vk+Sb0kGd83R7zgO7B82CVcmyXBkDTt
	AIxQ8DfSClTHR4/Yua7pQUBpnFncHH2uuRBgvJ8XXG3WJ/GAnbCbNdcw
X-Gm-Gg: AYBFou1mIfG10GAnsv1epg2YTodHH+u1cF62MzRNM4AzyoPmsa0M1To7a5YBNPUyiaG
	5E/B0JTJ6bYsvYhhT0lxTNJQrASFMnO6zmUAjtRC+haUOixjNBcXuBUW1wF6DW0XouYCUcRbXqv
	HGk1FlU8W6CFR1XopdvTX0nNkeNO8E2hReNW1y32GX6YPAM8xtRaMc/APNGWfoZeUck7QoYO1EX
	sPeZIKFJw3uY40HpnZ1MmSuQHittGcMGHop3KGQYWAt9K1D4M/c85I5FfvPfcT0MVkjh9UQHKdX
	x6qwHk5JZ89fCzkM0lVcj1F71gLA1z+2w5OvapKOFYkXZafmqnPgnsjjJzZf/B0YQBorQ/gsDqw
	fwczR0lrxBbfsd0owZSi6esBqeg6scGbOjjb9ZqukHSWuyQ/MUgNQRPezGJI4n9CiHiKVkkm1tY
	29GulbYSgl8CvrvIj0xhEL7JnC8QIFqcgm5MXF7vB3mPQB3awJsVaRd3QE+z4Qkg==
X-Received: by 2002:a05:7022:3f0c:b0:168:3243:c91a with SMTP id a92af1059eb24-16a5dbfde08mr4952922c88.13.1791600779010;
        Fri, 09 Oct 2026 19:52:59 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567aef5sm8975712c88.19.2026.10.09.19.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:52:58 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Accept unnamed dma-bufs in the dmabuf_iter default test
Date: Sat, 10 Oct 2026 10:52:52 +0800
Message-ID: <20261010025252.3716641-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABdmKX2VHqWrPb2O3Uqdccx=nP66gECU0kVc=4tZdGqSEZvuGQ@mail.gmail.com>
References: <20261009-selftests-bpf-dmabuf-iter-unnamed-v1-1-962ee94f7a5e@gmail.com> <CABdmKX2VHqWrPb2O3Uqdccx=nP66gECU0kVc=4tZdGqSEZvuGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Oct 9, 2026 at 5:07 PM T.J. Mercier <tjmercier@google.com> wrote:
> Hi Qiliang, are you running this locally instead of with:
> tools/testing/selftests/bpf/vmtest.sh -- ./test_progs?

Yes, I ran ./test_progs directly in a Debian testing VM, not through
vmtest.sh. The VM runs a GNOME desktop on virtio-gpu, and gnome-shell,
mutter-x11-frames and ibus-x11 each hold a 4 KiB udmabuf without a name
(their fdinfo shows exp_name udmabuf and no name line). As the
iterator walks every dma-buf in the system, default_iter fails on such
a machine before it gets to the two buffers it created. The minimal VM
of vmtest.sh has no such buffers, so it doesn't show up there.

The subtest only checks its own two buffers, so skipping over the name
of any other buffer seemed safer than relying on all of them having
one.

Thanks,
Qiliang
