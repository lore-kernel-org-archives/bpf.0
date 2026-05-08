Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7213346A8
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277529; cv=pass; b=BbhkltIvotjmZ3+BIsDS6ae6TLAGaevAiYvMW4+7TNdSJchapzy4nB63fFjOTANY8CJb5incyhG11VhT8/leO9ykfy7+FZ2omc+Jx+LdKliwMqbzEe2Ed4o622kMVYwX3otnAUCtn+4p9yBZ9nbnSSzDQH0nr012PXyTXE86GYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277529; c=relaxed/simple;
	bh=LlUMof/dbU2rlaREyvSYkoJRtq0NO13kmDTQ1RVYUAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHrs/MAgEFOH9OSj1wGEusRZcMMj7OPMblJ9906dDCrmUZHB8tttY5GmswnATpxA5bet+x+pVS1XbWMmnonbmJYPxCEbL4WgzBZZ7owfJ4DBk8v7Z3Xel2qjCnIWr1Of2W5f6bjcgV3zbXSArChlWbw4rFdAIPqhOBM7C6WOkdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HrnVB6PQ; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HrnVB6PQ"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c8f9846c8so3641568c88.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 14:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778277527; cv=none;
        d=google.com; s=arc-20240605;
        b=AXzvdUsDhQF9oOTW/mt3DxBrUQhj6ehkRvvmHW39R9gP3M6IgMf+Q4WbAZT94A9dUy
         1U8Wt6RwEamXpO22sXijMJCp9Uzt9R6i7ahNoohqbEUYWO/ImqL9I9peHivlAqQ2r66R
         3w+DG4Gy9tIirmmB/M1zsnnb05PhQv0weSMC1E/SPu9RGRLwzJautfYABZ4Uc8ACKy5J
         NVxCAEwyOSqHLWY4xRtYSK0tRXSJ1HKGFrkwUoCO+YKAWUZXf5RB55Z/isIgq/Kp6xu1
         ZXC7LkDV2A/fQgeAED4GS4VyZJhf7TSbzHZ2s5L1c/9J+UcvJduVjnNxVhoXsMtKLtsb
         951g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vClVOnLw/RbNZtmj34cBoCDYkXTPG7hHOtTr6U1/MWo=;
        fh=a01REBkf7CoYaFEV9ottMcz/malsf0j0DNXaQrNKyRw=;
        b=dQUluR4mi/GeO4p7oZOvCgYR8sWKJ7hrGG2AMCpCI/MglVzZG7ufHXA7Yr0FlX/g/D
         0trOfFbmp0U5OQ0mW5GPF/1D8sydHuocSbfU5KmkVxCAQIVOTg3jzYYnnKlq4YXz/4lB
         Uap3Dk4+CXgp9PFpEbu6nXNEgSx307DKy5WnHM6PfkTWNZmqjMzTio9P0EG5UMM9vi0y
         uEbCwX1y+Dy+IfeIine2VgBTw65/LmfVQniQyH7Iwc74wNj6IRna3RK/7YIevb0gug54
         sYsITVMokgJf6xAKgIKLSRyfwpHupeJH/jnT+PithU1DlrUosSy1tloUtvg7nu7584xm
         E7bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778277527; x=1778882327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vClVOnLw/RbNZtmj34cBoCDYkXTPG7hHOtTr6U1/MWo=;
        b=HrnVB6PQhiDdOT3CWFFAYT9GyCBj4JfA+LRw/3k62qxeXgwu8OHcNyL8cEC2dRa7Ih
         hvHntW0A8GLLSjrKK+ijQr+r6idS/KQ6Hf/Hv+hVyQZP1hd6eI+5lubJPxHs6KMhbvNX
         2Elw/ipilOf59vQf7Qlemdyblfcq3cS6qDZoIAH0VHjCEsk0jzVGk5rYhoTrsBqv1SsW
         7gyXVk+nudl1/7IpyCEKuuL2X6bAC+tTlb6osEo2jc8wzxf4ckWqXDkKy4rIyw8m5fkX
         S1tMVVA5NhC22vPdht8K14U8TZT3OrYV7iVuMoYF6vxbuTRkV+Umg8xFuz0E6bRqQFqG
         nXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778277527; x=1778882327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vClVOnLw/RbNZtmj34cBoCDYkXTPG7hHOtTr6U1/MWo=;
        b=TkB/sTKYVuIijV0mPkuOmh1BpGp68NBveNJSWArAMDOeV6sBsVQD0YGyVkcvBzzqo+
         HqGnegzA36Z5Zixk1/tjWg9HaRmZxVcBnMCpkOf6yaJxrT2GroTEiZLaXlzW7Oaq35SO
         b0Am3fMBuOOgRblYKUzAOfEisGizDwrnGWSHb7Ie9yptts8KCNsJ0vo954Lj4Nvp2Tli
         PsZP/UrmqY9xA2+h5Z6lJSmqfb20KuY33GNU+D0WKliPR2bZeNBystyYj75U18oCx5D1
         uPmGzBoouPXtKe4maCE4zZi9/1ZSHxCC5r+EJ2kXmkhGq/sa+IknOKn7ur2WrOWiCrNj
         okoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8auDJdX/iQ1DaB1ybRg0w4z/vBXSXYfPZmzsWC8S8EQpvbeyty5mCm0K/y5RcMM6vK65w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQp8Az7tBsSOiAd4bUhB+LmivoYT68F6mTYrfHbyXbn2ru2en
	FVL2dw+mwJL4kvvhh2t3EQO9RoV6RCabgTpql9VF6fxQ1VfJMFjVWju6RIZESe7FQAHBCcZuvcU
	E4IkGtJ6mZmyx1fWWfWwaKQJ8/teUgMZlvuhqJgqx
X-Gm-Gg: AeBDieuJ/6GebAhUL1751JhkO/q8r11/gP4Pos4HIYG7ird+cqzIiVEt2Vi07MwbmtJ
	c7sWP2ywrCrRGJtupd786MIsBKrBetbcvvCCMmZJlTdvSZdTMihWG0sM7Ne57Yo/m+lWq2CEAEZ
	+TPi71cheA1WFr7swOM4IsY+evrEWiOvucavvqb2gXJMpX3jZ7VHxJ90pg5rof7eKkZY9EXgmuc
	k+0JZk0Y5wq2Hi/qmWzMDwDFkHWcEPakCiCYKvGwTSpQfN9UQ6DM1VVduQJHl0zYudqk8o45nWM
	V7QJRDw12EzUzK8Qb3F1zZbqtvD4OwsTvTLMHfmKah5KciNdiKvWzRFSm4LGSqHsk8NbXH/hbmL
	0BvHcbfWAFee6sVOzOS/nj8VnsE6c384=
X-Received: by 2002:a05:7022:1b0e:b0:128:cf80:deea with SMTP id
 a92af1059eb24-131852d9708mr7084962c88.1.1778277526384; Fri, 08 May 2026
 14:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-9-kuniyu@google.com>
 <af4CV5itdz5Dzwo7@devvm7509.cco0.facebook.com> <CAAVpQUD01-UJorFM=4sT1b4XbiVF0TPorpzpU+b8DYXzn0FH0g@mail.gmail.com>
 <af5ZVL3EmKIfTcFQ@devvm7509.cco0.facebook.com>
In-Reply-To: <af5ZVL3EmKIfTcFQ@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 14:58:35 -0700
X-Gm-Features: AVHnY4I8jhJGWGTWCJQahgL6Wj9Av-IrNZFzkTICY9gL11rTPBov4fzzUheCl_k
Message-ID: <CAAVpQUBE1g6rb_ZuuJJuq1N5whQzxoh5bR+MPC=9-TU0JYo-Hg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 8/8] selftest: bpf: Add test for BPF_SOCK_OPS_RCVLOWAT_CB.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 2:48=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 05/08, Kuniyuki Iwashima wrote:
> > On Fri, May 8, 2026 at 8:35=E2=80=AFAM Stanislav Fomichev <sdf.kernel@g=
mail.com> wrote:
> > >
> > > On 05/08, Kuniyuki Iwashima wrote:
> > > > The test is roughly divided into two stages, and the sequence
> > > > is as follows:
> > > >
> > > >   I) Setup
> > > >
> > > >     1. Attach two BPF programs to a cgroup
> > > >     2. Establish a TCP connection (@client <-> @child) within the c=
group
> > > >     3. Enable BPF_SOCK_OPS_RCVLOWAT_CB on @child
> > > >
> > > >  II) RPC frame exchange in various patterns
> > > >
> > > >     4. Send a partial RPC descriptor from @client to @child
> > > >     5. Verify that epoll does NOT wake up @child
> > > >     6. Send the remaining data of the RPC frame
> > > >     7. Verify that epoll finally wakes up @child
> > > >
> > > > During setup, two BPF programs are attached to simulate
> > > > a real-world scenario; one is SOCK_OPS and the other is
> > > > CGROUP_SOCKOPT.
> > > >
> > > > While the SOCK_OPS prog handles the dynamic adjustment of
> > > > sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
> > > > BPF_SOCK_OPS_RCVLOWAT_CB via userspace setsockopt() using
> > > > pseudo options:
> > > >
> > > >   #define SOL_BPF               0xdeadbeef
> > > >   #define BPF_TCP_AUTOLOWAT     0x8badf00d
> > > >
> > > >   setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int)=
);
> > >
> > > Hmm, so you do want to have this enable-on-a-per-socket use case.. Th=
en what
> > > happens to the skbs already sitting in the rx queue by the time
> > > we enable BPF_SOCK_OPS_RCVLOWAT_CB? Isn't there a race? Or am I missi=
ng
> > > something?
> >
> > If the upper protocol is designed that way, it could be racy.
> >
> > For example, HTTP2 could have multiple streams within the
> > same TCP connection while only one stream can be upgraded.
> > But this use case simply does not work with a single
> > sk->sk_rcvlowat in the first place.
> >
> > This feature implicitly assumes a single stream per connection.
> >
> > In our original implementation, it traversed all (technically
> > up to 100) skbs in the queue and parse them like psock.
> >
> > But this will be unnecessary if the server drains the queue
> > properly before enabling the feature.
> >
> > If needed, we could return -EBUSY when the queue is not
> > empty.  It's always under lock_sock() or bh_lock_sock().
>
> But even for a single stream it's racy, no? Suppose I do recvmsg()
> and then setsockopt(BPF_TCP_AUTOLOWAT, 1). There is a window of time
> between recvmsg() and setsockopt() where we can receive a packet?
> Or you're saying that if it is an-RPC type protocol, the receiver
> explicitly signals to the sender that it's ready to receive (by sending
> it an RPC request).

Right, we can assume the client stops at a certain point
in practical use cases (HTTP 200 for Upgrade:, RPC
auth response, etc).


> If that's the case, let's explicitly explain this
> somewhere?

Sure, will add that.
