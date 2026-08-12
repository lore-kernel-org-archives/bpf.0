Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C2389460
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551549; cv=none; b=jHzlyhjMc5tj0gIBB66xOmdO5ZHSlZW84pV2Jd5H0FeybozxEPK28/ik8PrTn+x8yRYI2NxgDtbcRVPtN1NVwj69AkZXARWBOLkNtppiaDoEQFuC6eHrZRdxd+F2i6VE5Dwg5ojtuqRppOVpW3ZHq2/veIfa+wqGzc7nu9B6Njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551549; c=relaxed/simple;
	bh=gd3cJnSHvAkxEx/3BimlROho8x1r8DhYtZ9afl/+2os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZinIqpSiTZekcER7LLLL30GmTah4/EpSP7flc7HRV90ie8Q62oia1AU5QjoOz58MN6G4lEa8bc6PLu41y+YvOAcILnWnzexuyvRUAfdIaY9Wtdp5/eRa4uVfHOb/tU+S/GRu6LgGMpDc5pLhTdzecKP8bf7lrV87Q6clvULK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5OPbYq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5OPbYq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D199B1F00ADB
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551546;
	bh=gd3cJnSHvAkxEx/3BimlROho8x1r8DhYtZ9afl/+2os=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E5OPbYq9dGd7i3ndWlaOMzQ1gPgi4bUMfbMdEnLcOxGH/rK2aTpPS560wFqL5o3vL
	 YTGC6qTpZ/6MbsMHWV3t2ZN6gtRO61sRfcCqxgIbRvUq72AHyrc72eU+T6pPEji6oB
	 9/MVfaZ9HSouJ7+MBMAgR0WBmNpUfXkVZ+x44L1wDyTKzL0TNIhc5c+VaK3gevtSeW
	 b3oR1Lp7XpDy7EJuaHDRQ1pjEf96gXe6RY7/sG93+URGZgkwjY9zlsn0oh8ALwDU3l
	 m3ktv3PfCRYw1Twj2HLNqOR0CgpMVdHe6bROGK3zYy/h8IU9L+M37sCX3aQ7Ey3/Hb
	 MtW6DcVyuEblA==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92ea24a2dbfso100526185a.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 09:19:06 -0700 (PDT)
X-Gm-Message-State: AOJu0Yymt/luOIW46f7RUiDJNH8l1iw4G5jma0ZM/rUwUnFyYI6y37nk
	cwQ6w3CLMYZC3gG/bUY/XyabxkUlIwHy0iyvfuXweLQ1iyr8q+ATkVJ+/xXHClXUwucq2GDC4V5
	GfGAl3ZUsA+FeLDol5qSpIiiyhu3KyaM=
X-Received: by 2002:a05:620a:2806:b0:92e:675e:8ede with SMTP id
 af79cd13be357-936b3abc728mr530936085a.13.1786551546021; Wed, 12 Aug 2026
 09:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812154328.72834-1-mahe.tardy@gmail.com> <20260812154328.72834-5-mahe.tardy@gmail.com>
In-Reply-To: <20260812154328.72834-5-mahe.tardy@gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 12 Aug 2026 09:18:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7J-xiABqCqF7f_tPm5wFxDWhS=dDQ-kxndOX4Lp7Hxgg@mail.gmail.com>
X-Gm-Features: AUfX_mwifgA3oE2AlWFVHT72inhhp6xAcOjWVX1fkauZKHUPS4HghxJUypMuNz8
Message-ID: <CAPhsuW7J-xiABqCqF7f_tPm5wFxDWhS=dDQ-kxndOX4Lp7Hxgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/5] selftests/bpf: Test forbidden
 bpf_ksock_send() LSM attach
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com, 
	netdev@vger.kernel.org, sdf.kernel@gmail.com, ameryhung@gmail.com, 
	kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 8:43=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> The bpf_ksock_send() kfunc eventually calls security_socket_sendmsg(),
> thus creating a possible recursion if a program calling the kfunc is
> attached on that specific hook. A filter is added on the kfunc
> registration to prevent that at load time from the verifier. This test
> exercises that the verifier will reject such program on that attach
> point.
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Song Liu <song@kernel.org>
