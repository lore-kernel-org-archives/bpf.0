Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5CB324B20
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581701; cv=pass; b=pQbiwEialeuFd1A7Z6XW4emxO+hjPUd+L04b9d/0r5ZfZ5abIgphh8NXE5LktvW2auJD2ypoFbGLS7NcNJzqyGnqa0yKBsZdiHJ8CLZmKFv4aYRlpBTDBevx6GMr7wWYiNHZIfOo7d6f7LQg+dEj9NPgPpHNHEdvXqMRqcf8WvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581701; c=relaxed/simple;
	bh=EtSa3a4s7pUIWy8W5ASP2Hk6Xhg7fEmw0EI/tsx6ptI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTDwpph5ozJbtUxCBkaijOI8YNOYf7rm3o92XAMsg2OzoOqhxExTGf7Zt9K0Zmo3Cqp+Kxc0GFOLbDGvk+ZmoLP/3wAAXu/9ug5oyl3pTQF+ZwJsmzg3xNCvSt51DHyjPRymPYUFam6BKDxLgIv9xXfUWc/6Uj7NC5NgjkriJHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHMA200h; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHMA200h"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80b9993928dso21966177b3.0
        for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 10:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782581699; cv=none;
        d=google.com; s=arc-20260327;
        b=XMcN6zyKZU3RaqWRuwdkkeY1pc238TXDUkNstJRICInKYAdLJZ3rEAhCfSJy12ksYJ
         Uwak54lBrR9jSfVjnqbUr7uxHlD/wIAJP8a1YBACWyjPPUaJVXKq1gW9DrUXEfJyVUe0
         MGOrN8sbKehyyi1K/nbA/8SgBoK/edYBYguTzyQTsENDAdDMpOC0BaHJCQYeRRLxGoqL
         V7sPq5mMuHUfsTy4r+fUUO3SZ/AM3O7DRUWE/JgHX2pxncMzmCFmM16JTDFBgCfsH7K8
         8iFGa0axzcpjsvHK8syjoai6iXOIG1JpkeGTq/aqy0akEmm4ahUHg+BxisXeMKETwc4c
         TmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dgu34QrpNJdt6cwZYfvIh4PfqfTJtLR90pHZigkhqr8=;
        fh=2aCXmKs/P3WiK4T1jeBRtuqx/1uh7EZk2x7W9SOGuV4=;
        b=LyUDqCjU+YUuqvdIRi8ak8eGAOdls9oAC4vp2gqrMS2Wo4/gfhtZ10LAsKSfMF5cu1
         dCHBN7pIEcwsfK7X2d1+lpmslFk5QdZAgTUtbnNZ0tfO4ensBdnQzkSfT5aAsXpnCxg6
         mL01MzeXU3zt+xIVDVbrQMHlo+A12e+UHgZej0xlBbgG8660T/4r3YA7KscShOeTJeHv
         6syisgOzm8WOUNYQWMuGgL8NRqreTTpYL0PHX2m6VR2XfVhr9tTSrFACxiVoTFHD1Wri
         i9SsUeBO/woXnQXB9le2Ewn604kWRJpB82MJQQ8LjE82J7XAq1cTYcD/xEVtV491Qh6+
         OwuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581699; x=1783186499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dgu34QrpNJdt6cwZYfvIh4PfqfTJtLR90pHZigkhqr8=;
        b=rHMA200h85kj5cgUDkXotqTcF9w2HC9z0SaL/mGqx7SI6VLThAmZXDrzzTQPc5hlK0
         y53Wz1YwaZT0FqhF7aVKBGu0UGUu3B8i0hQuXd6Bi5qgoSCQ6e/NawDcvdKaL9DeyV7W
         xNCd9PE3wRPCU3q5BophlCLtea/GkhQ3Ir5/XkBn7Rx6i/raJtK/rgmoFYfXRC2M6Y85
         JFERMRi4gagYs/2mrf71a1yYqiRdwkRul66mFIdZXJnDO65wavzoAXkG90rgp2bpaZ36
         PK8ehOMdTZtJ+xNqT4P02gv36vQAngW5JZsXpZBThPnFMw4G4dnk5MPUPD8SOKKmsVyz
         LpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581699; x=1783186499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dgu34QrpNJdt6cwZYfvIh4PfqfTJtLR90pHZigkhqr8=;
        b=Bj/seNtuqzX+EDHzeN4WTJ9j44goT/nGpgZe2IpiAEQmFmV/qoNd7grVPaTJTLMXB6
         tbDUDq7uWfQEXyQ4TVCe8YGXOElpctbgaPiS+Ls6jVsW4GYc/fYU+eUgU24DrBKINNmb
         s4q7CceknumUiSxsKbL9091fq/1yv5LagpoxL12DVPyeiSIuM2OMRq1Z+0IP1ej8UlZV
         hxHtpx8jyW45hUJHjAB0l5pmxaU+NRmUiiIokcG/+XVnT9vcvQBaEZbaR9tg6yc07mLa
         WF1KWf2hxgiFvebR4VBVfAUmvOb7KJpEONwBHIfeP9Xr22btE1rl4I6E79ukS95vjAm8
         Xbzw==
X-Forwarded-Encrypted: i=1; AHgh+RqqGlgcSDdWJmwTtst6rp0zBST988cpqVi1JDWzBABlHZ3KervbOjkyek7z10dUS+5Gwrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxek8PFVCAmk7HJ0duya1cRX/7pUWiS+uWev6mYDnefT5qntC1r
	c0MhDsr9d8Rnz8kXcKEKWaSDsCWz3UYxIsiUyEgCy1xwh16YRFHW3A3vilgA64lVy+1Zg3ZBpus
	3wEyelDD2dYfODSgbTTXrPdLtosOlKbY=
X-Gm-Gg: AfdE7ckV3rzY0ziAXqS4L2Ne8O6GTUCLd0MFxGcXsOUFBXi5seYnpw4M1xzT3N7Es2r
	evD2vv/sneSUbXBdWz/CwhMI0p83KGk1FPtyl4ksLZ81OSWVEJE4vc4rnWIHNTl++EcgO3cypjW
	djzsiFQ87CAsfum1MvM/eKau4t3rjx8nGnsI5OhOO3COVWLiSR6JX5Zb+J6xzLElHTUOzJqDcGy
	7WRFZLyqmSDDn6EEHeR+xO8ftEfKszdCEUCJqVcaextJmyCU8YZi546hEht28Egew4GiHMmu3YP
	/faL3KNd2fqHeBbOGZrJtj+NcuhehD6BVyuEYAxiX82AYeqZ
X-Received: by 2002:a05:690c:e370:b0:7dc:1609:53ae with SMTP id
 00721157ae682-80a6a09b112mr118115867b3.25.1782581699520; Sat, 27 Jun 2026
 10:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sun, 28 Jun 2026 01:34:48 +0800
X-Gm-Features: AVVi8CdMPlgvdtTlopQ1G7HcBFTuPVL00FJZpDP6g1ISEPYbsnwP6Z4y-kISnc0
Message-ID: <CABFUUZGg1B0vaw9DFX3uTHxpRyyGtvn04Ae=Ob-VmnuVJB4KLg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/4] bpf, sockmap: Fix sockmap leaking UDP socks
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 4:37=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> Fix for UDP sockets getting leaked during sockmap lookup/release.
> Accompanied by selftests updates.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Changes in v2:
> - selftest: drop the original, adapt old tests
> - fix: change approach to rejecting unbound UDP [Kuniyuki]
> - Link to v1: https://patch.msgid.link/20260623-sockmap-lookup-udp-leak-v=
1-0-05804f9308e4@rbox.co
>
> ---
> Michal Luczaj (4):
>       bpf, sockmap: Reject unhashed UDP sockets on sockmap update
>       selftests/bpf: Ensure UDP sockets are bound
>       selftests/bpf: Adapt sockmap update error handling
>       selftests/bpf: Fail unbound UDP on sockmap update
>
>  net/core/sock_map.c                                     |  2 ++
>  tools/testing/selftests/bpf/prog_tests/sockmap_basic.c  |  6 +++---
>  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 17 +++++++++--=
------
>  tools/testing/selftests/bpf/test_maps.c                 |  6 +++---
>  4 files changed, 17 insertions(+), 14 deletions(-)
> ---
> base-commit: 26490a375cb9be9bac96b5171610fd85ca6c2305
> change-id: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7
>
> Best regards,
> --
> Michal Luczaj <mhal@rbox.co>
>
>

Hi Michal,

I tested this series on bpf.git base commit:
  26490a375cb9be9bac96b5171610fd85ca6c2305
The test environment was virtme-ng x86_64.

Before, with only patches 2/4-4/4 applied:
  sockmap_basic:  PASS
  sockmap_listen: FAIL as expected
    - UDP test_insert_opened failed on sockmap/sockhash,
      both IPv4 and IPv6
  test_maps:      FAIL as expected
    - failed at the new unbound SOCK_DGRAM update check

After applying the full series:
  sockmap_basic:  PASS
  sockmap_listen: PASS
  test_maps:      no longer failed at the unbound
                  SOCK_DGRAM update check
test_maps still later reported:
  Failed sockmap unexpected timeout

However, I can reproduce the same timeout in three consecutive
runs on the unmodified base commit, so this looks pre-existing or
environmental in my virtme-ng setup rather than a regression from
this series.

I am not adding a Tested-by tag for now because test_maps does not
fully pass in my setup. The targeted before/after behavior behaved as
expected.

Thanks,
Sun Jian
