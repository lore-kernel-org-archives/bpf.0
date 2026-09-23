Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079851DB09
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201679; cv=none; b=o+2LAnPvBAUI79QGkfqNBbH07+qe/UVv6ZyEBywqBpS80s/v74ChNP4OH6cWcJ0F+Ep3F9Vm2u64HoFuaZ/JWWGmecuAHZDzfUdHbhhq/b5uZ627N7QKfQ/m9aukfErqnpfP3LNEyIuvJaVEQMz6AtHJn+dCEpOJCmj+n95kFqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201679; c=relaxed/simple;
	bh=uJ9Ja/yw3DCK+Q8bIovnQGbdgYhEbxK9PA4FsD7RXXE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=MxFCYKUJQmYEby8ZRwhd+qzkCRlQTmqwsVCId57twQD81L6+TZdhxeKvGA6459nO5Vm1qcueZY3LxgfWLqOT58Q2HbcNrBYkHlmr1R/haK6PzO4WHAjSBtOekSJGRClYjJYxEw9ip+lcW3O+xtWaN354AR9tOZJ97dvT898FRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdJHqS6H; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdJHqS6H"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d04d740cso741123a12.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790201678; x=1790806478; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6EYOTy+QnW26hbR5HcrXAKWXiAYxeIUHU6uN6hbrPqA=;
        b=XdJHqS6HDCfkdZn7Mo0OIKwZynepCer74nEIhXiLe67o+fYf8Ax568JL/peG4JyaN1
         NFDNQhYnPi5i3ygaFZrK49tk/2u4VWSMWJRHfu1nklG/2WJjzNOcqk8NWjRCg+zym4Oh
         9Jxio1BAVtYpJDn+JIEby7fVT0ST7ryfhqcF7EmOtjofu43z0Le8ZOPm+xieJkOWAhcy
         bgKRYQfMcmpIh79ZEmXMfnM7yHHd7kTF5EFARhYnm3PFYRo7fXdGTwzHbKtm8r/2kZuw
         4Lb85PJJ4G5nSPYoM8b+1XlNcgCfUdFI2DjuY1uk8v9+Wl46VgVPek8Dx95nW4wzEFg8
         TqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201678; x=1790806478;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EYOTy+QnW26hbR5HcrXAKWXiAYxeIUHU6uN6hbrPqA=;
        b=Viat7/UPuqPmOBx3cSL7wJeQglKPqvQ3J83+CUBYqGWUuJbrnwBn6gZ4zymRuoDzQS
         7pMnlupC0mDqSUCIGVrSf14/IU8eJ1LAevfgLF9IXfUidUurYkIGiwj1OcshSIzIBtLL
         gC5lU06JwCH72Sh7/vhEb0PJheYOROy3dEGUONkpOmOEvkaNzOLVUiOTTGEC1ghqh8Zw
         k2TTHMDYbKGNngWlfuWnpcSpKYzwdaQo9Z/W3ZO0OfYKHluyamYJVVGPqESAXfQWEqb0
         6+KQpj+bOKwjBP0hl750xAANUsmBZsy8Sr+8V9epk6yF5OZDPz7ed/9lh9bj1O1Y6jzf
         ZKmw==
X-Forwarded-Encrypted: i=1; AKwUvBxkzVeSkEnMNv8xqXDQlXIzloZcR2EG74/FMhav7fvQYB4PMG6AV8PVAWxsz6AkYj5hfk4=@vger.kernel.org
X-Gm-Message-State: AFuF++mUCBFx347429QJiQQFlGv9Jwu+Cl6Vq45RjFoEnVayV144FdEe
	k3e90lbz+SNscLc9YxerQ6+AijrqU/Z7ygE31FVUNW3O7ysxwocV+NIC
X-Gm-Gg: AYBFou0hBKXrlDuIugKgRBjgmywsi533f+GwxZM5Lh6jw7eOTwF4zYj3Fale/uTCeHy
	YLc/SFY6jS2VOu44GmLbh7CzWlvVdDolQt+K7e5aBK6UaxfOhJdWEQ4lQdlNVhwjgMZtFUbXfue
	QgTEWf1zNHNDjpHEIYCJL1nZhGTboxt5JD6h65Nfid369xzYl7tlaJJlNACUHGKZrXooyDf4Rph
	D+BZR3YX5gp5n/ceE0fMHWaUkS6haATigH/s4T+BK9JuZi87QT27ltdGucPCAjW2Z/bH15Y6y+z
	oL2Vk2GH09FCZDeEMTWR4na/Ul5pmMqmi/ftpcncs45ZWGQj0Efl+nrCdiGO/i8cMBymgNmN9jN
	MlV3Lkm+4QcZKOeuGfIvO4tIQOuItY/OAsscJx/Qk/S+rjFM7/AvnCNmNiNAoFywI2ztHl9nZhJ
	PXy4KBysnoOWJGoK4GiTTVbNIYS5y/h6slDcss91aAXgj+6fh7LQ3xEUO4+cF2OyZ2YFKLXc8Pr
	vH8X9MdB5C1CrDgXHa7SWZyP2RavfbyRyEZ3XipnQOZVlPawQiAq/USsi5wTpG4hld7f55HvCgr
	014f5+azevsFTpY=
X-Received: by 2002:a17:90b:2e49:b0:3a0:94af:19f2 with SMTP id 98e67ed59e1d1-3a0986e8093mr382567a91.5.1790201677809;
        Wed, 23 Sep 2026 15:14:37 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5c4sm1012390a91.5.2026.09.23.15.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 15:14:37 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:14:37 +0000
Message-Id: <DLN1J4YTAX4I.15CNAUSP5LQC8@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Yuan Chen"
 <chenyuan@kylinos.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf: Keep target extended until its last
 freplace link detaches
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <chenyuan_fl@163.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260923090635.368488-2-chenyuan_fl@163.com>
References: <20260923090635.368488-1-chenyuan_fl@163.com> <20260923090635.368488-2-chenyuan_fl@163.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 05:06 PM chenyuan_fl@163.com <chenyuan_fl@163.com> wrote:
> +	u64 freplace_link_cnt; /* counts freplace links extending this prog */

u64 ? It's bounded by BPF_MAX_SUBPROGS.

pw-bot: cr
