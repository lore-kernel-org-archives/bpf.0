Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17692D322E
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 05:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229305; cv=pass; b=u2z3wITGcQ7wgV+oAH6QOJVQ4yB5qpp7O72fazgVs3i5J3bdACFjwz303nRqD7AxfCnGRtNoA0uYJwcE7+hMt5fZBKsXQNGDlMjmbVEna+EbwvKSjd9tPV4NL5aUw/qw0v6zlcbzrGkuFsD+b27dhzQle8Q7V8nlPQY4n5X72vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229305; c=relaxed/simple;
	bh=pJUSotdmTzr909dQmu6Z/4Wm9WvdYY/zfwb72+1evp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loot6ED4n6Xn+ViYPLIRFH+9FdwynueBanNtWZcaqTWwYxoX8fWnhwO5dMOyGEfOAgTeemvDAvr/a3Ih/i07YRZxkVK3izRPP8/7tXd2X2tKMVTT4mdfFxKgXX8zm/mxmvZSGupuBvgjf6OtH7QupgzwJf99SQ2JYNIsE4Lxqlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuFHBfzM; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuFHBfzM"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c565476d7so4609182c88.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776229304; cv=none;
        d=google.com; s=arc-20240605;
        b=cN87LxN2MBNrbfmq+xuybOxbFka6W14iAP85N1KNJj2AS68keUcEJBaCkpnIyVpf2X
         ooWDe2g0vy1okiay81QWHus0QFZaL3tsdtjqHriXtOuVN/gX5xv3nyi+AglcuGZwCg7h
         otJ2wRI2CXNqjQEU2rvI67EIS4hG6H4nIsqffyf4kZW7Q97a/zSd4pb6ea6plPpaSJIz
         lvpNrTjwURh7+dz67VRStm8u00+mPbgRRSk1WhoGvU48r0GH0urm/NCpNE1SJouOi000
         BDCSIeue7GvoG++mgNEg/7x/JZCegvAsgRhR0z2GUM3I55b4lvadp4wev9yeIMzRfnT/
         koOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pJUSotdmTzr909dQmu6Z/4Wm9WvdYY/zfwb72+1evp8=;
        fh=uBgK1LQzX7fMG+633hbZtkleoSCaByAi9k7xYY46gTQ=;
        b=UD2RoUIf9RXcRDnlVm5SEyRMJf45IFo0o0UNqdx4eEwzNMfIsmiP9eNpcYHg/o/0/+
         oSKLhPtxYp+5kd5aurH/7xIM/UJw+Tm9Lab9Dq/mE1rRaSO+/SZehL8b2HTuIERzF7lT
         nZ8PXawx1lnFgFugiORbtKpDrrOn55JohsWJMHozdFInCPu1aU3bMd0FvxmFMK8moaUO
         XWqxSSnNbISoj9HlGEPJmyIssXrTCDK+2YEFAYfX0o/4z6DmcWo/VIv7ACUJRIpxsKcW
         qSwW1Qsejm4GAneuzDoCCWA6XHVotTJA6aa44nWWk0bzCuCTti/U2FSBDTk0mu2B77ON
         3LFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776229304; x=1776834104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJUSotdmTzr909dQmu6Z/4Wm9WvdYY/zfwb72+1evp8=;
        b=MuFHBfzMtF6ES9S2JbmLmV9lxwnzw4thqZh1QNxMylBJ2vKW5dQKVHXsBYKRa5SQiX
         H0ePjRksjMRzPopYZTL2em7AQcOFh78cUw24WaQH3PI5xHiytKL6HPplWNouEDyAFwiX
         96kkrfKC5babTuD4IFpjIwOywrCDeTGFtltv5nFJSVTL48CGeP6k6wrtdXrkVdBg/j22
         IjqVktvQz+YH7dMPT6FBNN8xIKMW7KOKSMEO3C4JLAC5X68knqEDMy10WiYRrRJb9RnG
         /jIvgTOzc8slnQnCzKS7qVIMVcGFuwpIpuQ4Cr6TJj/Mm+553rrv6xRl9ZHcT8Z9LUEz
         vvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229304; x=1776834104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJUSotdmTzr909dQmu6Z/4Wm9WvdYY/zfwb72+1evp8=;
        b=Z2Eq+fsjN5Tek76EdkWi5Js6WfS/kEsMGFqmQw8exaL3iaKrK0BXDvmCD/XgWKRaHS
         CIXj0eJgUz9An9L+IFUkujMKaGh1yyv0VFsroJ59xcxU5/+fsXgGKEinBmE/JyHdBfUs
         lmz54anoXqwwHwtRaiKe008q6NhHqoAXDl2RKltht/AhFRTaS/ZIswTdZcAgROHI2PqH
         gkzrYOteRu3qFTLeMHbdsCo/GpttEIH4SpcOslHv6JhyIp1BPLycAuD6u+Fo20s6ivcP
         3Xs4myaP/KzDhyxTyKahm4nehok+ANuhAoerdTn3N+HM79Ha8p3Wg3DKMNEYtuQg6pXY
         l1CQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZZy1s8xFncTzPhGbxHJZf0dLWOVYoRgOC77xBIE/irWgUbsvwlHsDjUzp24jUpj/UIds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKYQzSM6lptdmYPkMjIFtuv1xQCYJyjN3Oh3bdaukxQl8zQTBw
	g+WoLAxRbZcj85gOqeRdWojFQ1qSxayUM/NNuaMDJHYo3djmauhnxdTOLdDlOBIt8CYoDoyksCI
	56ruXSEUmqDN9KPXkZvMQyW44ycZgy+re6KOclmAj
X-Gm-Gg: AeBDiesFOq7lAyQfbLqltJiyyc1X/7AkOyc+3zGYmX9GrNYGb7fI1XOHKjPuiLnO9Pf
	9fV22YAfacPkY0cVfDt+1oulGnUx77ZTIqUcx4i0Uc3aBaRispBlu4LXmuoYY3HcDB1hMqYSHhW
	rV362ccXOClsFNh3nEPote2z23atdhwVTEy1jIkMSD7HU0wBlIKs+HcWUXWFhzSWW8t+PNr+BZn
	ub8GNaKxEYBGVPyk5k+2E/+Npz5hVXUYxoDl5aDMPQVr8KI50u4SobScRFxeITnZqT8ZQISKT8z
	DZwbBbvaK/NB1/SuPgCVSi4oTWv1Sn8rk01p4dVLX2kDRnGIzmBAy9h7B1f2MwqxlPjGHqJAHO9
	xrI3T3DrPst6CW4dZRtjIUZ2dRQieG/tkivLNVwbV5pP5mGeUODpKFLTyyGCfU+1RjO9phmZJOw
	==
X-Received: by 2002:a05:7022:389:b0:128:d24a:a5c1 with SMTP id
 a92af1059eb24-12c34eeac88mr11841217c88.28.1776229303335; Tue, 14 Apr 2026
 22:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
 <20260414-unix-proto-update-null-ptr-deref-v4-3-2af6fe97918e@rbox.co>
In-Reply-To: <20260414-unix-proto-update-null-ptr-deref-v4-3-2af6fe97918e@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Apr 2026 22:01:31 -0700
X-Gm-Features: AQROBzAtbLi74sgP-HJJxeDMhYc_8XgwX0AD5wIVbleVSSv1wtKRsUz6FlLLeDo
Message-ID: <CAAVpQUAe2dhWaMnKPH=uvmGxVA_dd2gVyCL=Y55+eUJ3G6QOFg@mail.gmail.com>
Subject: Re: [PATCH bpf v4 3/5] selftests/bpf: Extend bpf_iter_unix to attempt deadlocking
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 7:13=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> Updating a sockmap from a unix iterator prog may lead to a deadlock.
> Piggyback on the original selftest.
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
