Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793479971;
	b=JzhqnTpGSrz+kDe7Rtl7OM4xqlr+76SUtGlHf8LVgd4cjrjPxL80cnx0ow33epEFOfcJ
	 aD6ekJdFeMBblodZgmtau1JtWQJRW0Z3rRDFEMPHKL0zXSyPi7rC6GWTZ6STPBxmbGdCx
	 LlfqgP9yoxxcPL/OEk2vEZoykP1gxZTPCCO8cYwVWNNYHfeNeexbFouwNuedU5v1jW8rx
	 fTPC10TCQrXwPoqgbZyx/8Kp69ipSRuMh5kA9FdPmTuQc9FijtBKWYh8RpvJo89M+1/bw
	 fxYm3O59uoHOve7W3y5XAD4Z9ON3McSBVaE3miLFmzHcA4vjg9eUnnN94wy7/yf5vQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793479971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=icWN3ojVey3UJz1wKnjFg1vmnm5rM6DbNVOsG/C6lg0=;
	b=phEivjK2bABez8XpiE5kaQ8XYtVBVIL7/XMV6VQ/rRto14+fwGh92MzuUVs+oXdaDQp4
	 kv0hcow26O7gcqAaO71Urh+ICd8n3UiajF7P1fSYvlwmtbU4RFsAfU4vIPXrI3THV8aqn
	 5QSz3+iQ2YFJ9ugtBRvCvKUbBpE7dfGnBJEHVNDZolLV6ivb28LLXfJzuD4YTXYFIme/v
	 QfXlQpe2Rfi1tF5bZh47A40yy/kL0xr+zzosMvttOal25X+dA5eL8iEjvX4KYtC0BOUxS
	 m0jsYHyaAhOHMK/fhNllROM9eUfJlIuksSvr+84ODX0GJSmjRgIUklXildrWc1dJwtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JFRaYJYW;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C93606A31C
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99C93606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JFRaYJYW
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so832378a91.3
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793479970; x=1794084770; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=icWN3ojVey3UJz1wKnjFg1vmnm5rM6DbNVOsG/C6lg0=;
        b=JFRaYJYWcWvVTuMPIHDNfHW5cO1myvPNw8qm7zKdksl9asXKdRL5Y1lcuTsaTuSK/U
         LaDnk9h1oGuzA8qtB430ysb28YWho44jdiUmY1xTne5OhDWrormWHWRk9XFBqB5wjsxq
         1IUJTGn/qhD8nRgoGngaf7zx3O85hWtD9HgwsSE70gqaz/VS9TvZyJ43UgXBhMgnXOK2
         LvQrPvVCQaIT3OAL5eeIACZNi8jRe/kCkJCp/CRCR+lwh86UQ5zt6agNrI5HC9ZfKWFI
         RYhoKf58O+4sNa5zL/MnEIWowiygs5mGmYibwHqy6udPQBL0FNFcMDG65Jele+6B2VME
         k7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793479970; x=1794084770;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icWN3ojVey3UJz1wKnjFg1vmnm5rM6DbNVOsG/C6lg0=;
        b=GAUHCWq8x8LKgE4iZ0kBwxlYeNa9QVVT2YNtSEjvtMgAODT2xNZ+3K7zw0E6/DchQR
         HdjgkwMq6tPPZjfxWIjXYKj+i1Wkg9M9ooGFfeCBfzM2zQN4+cQlOAPpwceS4JzDmxGb
         e6qdAXzWm2XMiOc8b1SBFO5vaeFqrnvLHTLoGyXf7GJVph8BW9kkWemJzXScRyG9GuOx
         MYEHMpkSd+Xx4Z59Nez+0/oNckOLpNLu/PD3VKgD8JOvs3brVwYg5LikkTCGn+bW4ybH
         nQIrA/jBifzfL3+GAKodhhNddY7Tv4/ychNW26VKuSGUiMspmwZk1urR6YZ9ql+s0ilj
         DhYQ==
X-Gm-Message-State: AFq9FYLW19Trzs1MT3znYVujOmPFFcvJjipyfHsDrhvEd9XVL4D9LmLI
	ATJpg7BA0662FWxDjIubIke/HqkmJwZwMFrYUGG6skYj6g5dSxjLVpWldJAIQg==
X-Gm-Gg: AYBFou14MAHWmDjx77tQzKBXpGVH91P0SKxp9icFCWSzw/HJSFa+IBqJV86/6VJgnw6
	wXKf5pYowN4nHSAwPMpm2F49aaKNKG1cmmloO06fuLp8RQoiPtIVsmw7dKevwPhqj7GeMAw42Xx
	EE9bwXb3wTKFXXZC4eWyR5DHoplNeD1QYSt91HI8A65YvqeT1H5iQ7/uoDbIVqxPMiSxJ6f+MsO
	79kwIHaBVsvmUOK1p1MiIg/BQgyuIcrIYMfqE3GIWJcUV9xksMrMWdBuAKjaV2f9vRE2bFyhatp
	DWhYfnF7BvZjm6L8ujIbD6VTxDdypmXZMZlRcIICyU0KaNRxfvJqmnWQe5Mi4kA7l08sYZSCaP8
	QB/vsYpuGU7o7HdHToS0Unub0SNOy4qFrk+OCknHQWiDG9i2cb16YjPwFu8d2hiMyOnVxZHrjTj
	4H16edcTbkNbLXqOjqmhMX1qZfH1F0HA8WbN4N+IN3gaFXJS7ohR+IKePyeVVLXVl82Ggf3nLm7
	q25X4CMegZKST+ZbZlEaNW02fE2H0ur74WP0P6wMld83iRfBoNQeZjfcGjyQRU/nN5oniMnW82W
	KcW+NlLc+llbnS7QlXan8R6SJHbw0Q/v+ECHeRjlx0rkxsYunaIBznkhdyw9SbjoGPsJGEDrY+b
	EBxG8mz8qYgKhHVk5i+2qpjQw/vxgfeP5fw==
X-Received: by 2002:a17:90b:3f84:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3ae89776af6mr4824088a91.11.1793479969985;
        Sat, 31 Oct 2026 13:52:49 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8454327esm8389084a91.4.2026.10.31.13.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 13:52:49 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 20:52:48 +0000
Message-Id: <DMJBL7GLZGTF.CLA7HQ8IGYF3@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next 0/2] Fix psock update-side data races on
 sk->sk_prot and progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "Eric
 Dumazet" <edumazet@kernel.org>, "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Willem de Bruijn" <willemb@google.com>,
 "John Fastabend" <john.fastabend@gmail.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>
In-Reply-To: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
References: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Oct 30, 2026 at 05:01 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
> Follow up to the thread at [1]. See individual patches for details.

Thanks for taking it over.
Applied the fix to bpf tree.
The selftest that only triggers with KCSAN is imo not worth it.

