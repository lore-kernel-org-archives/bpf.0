Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC492E92BA
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373494; cv=none; b=P5lVlNxpDMj5iwCXfSDvzyty4whPbP13zRbkZ/K+clZNntbLjEwgZo0H07cumsHHsHIQh45iPNScyp45wzQlpIBdUqC/wVPSnY/+sa4mQalw7PsfME+eoBrkKeJkW+7ikmw6O8BQsW1D31ggorAb3vQxvl+xeVFnbGTM6iwR4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373494; c=relaxed/simple;
	bh=TGDF0NfqUind8bd9n5FNh1wHcjuEHBpsxqOITA2l+Xk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MiIQD6kc4TgwvnqLXOmRvf/zHgoe1mWgfgRw1L/flA68KY2BX0kXK+7DBFOw0G/QUKoYYLQ3XU+ewXjH02Phsr4UWXzn3FqQmiSiWxa1Z/mT0GX/PuuGW1tNV22jY3bvRkxo4XpV4kWYk8d7EpPPonn6h6RYi3L+Qz9I5z2P458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5ZunzOQ; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5ZunzOQ"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-48db76d98a1so645817f8f.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 18:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792373491; x=1792978291; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WISQLz2AQxQcT0S2L37UPdDuk3j2AQ3msq6Prumccac=;
        b=e5ZunzOQcCPj3Yoc7V3+SkVc77PpDED3XFmobT27ATTTXP8c21KQZN2uGkmktDpQs0
         Mzm9Wfy/l2V35qlD9FCNWdi8wvezHdad7qFccXN3dmQP+K0iP6SYqGV9VXkOCGJlld7F
         +Tje+eInhlk4k6azO9VwT8+owTB1ofkil2gHbvhTfeYJecx3Fl7d108SGTR7DGvZIeeH
         kF1jf9ggGxaf3KQX42xDYoDbOC8GvLu1HhlSGcyF9cQR1j0pxKBxwt/eLkA/ovKBR8Zt
         UihbQ+dxm/zz+2qObY5a5smx4RkIHYslSMYwNkUfVDHST677j+sWnj3mAhHHp+rMYyh0
         13Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792373491; x=1792978291;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WISQLz2AQxQcT0S2L37UPdDuk3j2AQ3msq6Prumccac=;
        b=NcM3F18hb7JexODNFaItHwMAOXGA4gLzsv2RFB8ykvEw2wArAfAQ6YINSF9qj1OKiO
         Fzlmjj4StJAarB0YbojCezKU0ogmWkSUoxqZWw6vE49lmQEnfdbFq25u4djMBs9pJlsY
         hoRKEejYyirlxym14J2rrz2CFct0gNU/Eyz387lwDUZmtPR3A3ExFGrNvjX39bRSP4m4
         PJxHDlh/PU85isKtAsE4I/Z7fxX8oYmn6AwifT193WLgeY8ko1r8VCV/UbE19x4zS5k+
         OQmlCa2Fzc56T5Yv083QxmzZJEs9C6vEvlRAcwNwImWS3IcD7juR/rxEvR+/Zq7CQn8X
         Mc3Q==
X-Gm-Message-State: AFq9FYL1HXfcC/rE6zOoU8jzjmrhZIQUFLIwiorJSI5J10HaIBuxkW+j
	2VAq4wEBOgw5ChtUoI0UnvAbhvGE0+a3W8cyifWN+O4Avi9F0a7bSmS4
X-Gm-Gg: AYBFou2FqtcfvXHL4Cb4HXIxbvwDnEIBFEJNbqBYDS8bt1DxDUHP6yDHVQDOzs0xa6n
	SjbyxZNKlD8zErtV08Je/qgJSzlEcjE34n+GilwbKXcv6BbcgG4zxXDEm5sCIwmN3dcwRvERsJN
	+LEsqeCeU7QphszBORRFCNED6s2dyzQEIGn2hPHfstk0dvQ31XczHknnaVUDLGvXs2AmRupYu1C
	Gm2njoCcTbPPoVh7KYNN4yQKc4XfeKoCZltpGzTz5qfSBqLOu78TIXgwsraWT+L2p5LzwVqTLaN
	xW7HMWQxsgHFloH81jBXYK5pzoPFKBsGCeyr5kOf2P0my+VGKGb9TJjHBF6c1H0LCFA6dtf/FoB
	oLasd32U6bxcbvpbPLwVyCgR6m31n0i9JBqdQgpgHWGITaB0sxa/Ht9qQugHwrNXSCPetufjfH6
	n3Nwcq0uEOX7MZsxfBq2lMjm4qOBoqYhaF21k1oUhpHOvg59Y2qIVRvTuvj5WKTvs+4r2bNmT38
	OqGROR8hzGllrGVClkA5MS5ZrSfhxKq83nzwel7XPmDhYTqe/fA3lKq1yDr2gUClTCMq31WC05v
	rNBD/bkcBawulToMD/s5qchq3xDUXnNcpwz3rg==
X-Received: by 2002:a05:600c:5492:b0:4a1:d992:9476 with SMTP id 5b1f17b1804b1-4a1d992951cmr116649365e9.23.1792373491132;
        Sun, 18 Oct 2026 18:31:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cf983b88sm232364725e9.7.2026.10.18.18.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 18:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 03:31:30 +0200
Message-Id: <DM8FDI32CJ1Y.2JOM7KJERMF7M@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix wq test by changing 50us
 sleep to polling over 1s
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <thamrinjonathan@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc 0.21.0
References: <20261005-wq-poll-fix-v1-1-99ce4bac59f4@gmail.com>
In-Reply-To: <20261005-wq-poll-fix-v1-1-99ce4bac59f4@gmail.com>

On Mon Oct 5, 2026 at 11:37 AM CEST, Jonathan Bastari Thamrin via B4 Relay =
wrote:
> From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
>
> wq test fails with ok_sleepable reading 0 instead of 2 as workqueue
> callback hasn't executed before check.
>
> This happens as callback runs later on a kworker and 50us isn't always
> enough.
>
> Change from 50us sleep to polling over 1s.
>
> Before (usleep(50)): 3 fails out of 5000 runs
> Diagnosing issue (usleep(0)): 23 out of 100 runs
> After (Polling): 0 out of 5000 runs
> Tested using vmtest on x86_64, test pinned to one CPU with `yes` load
>
> Link: https://github.com/kernel-patches/vmtest/issues/455
>
> Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/wq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/=
selftests/bpf/prog_tests/wq.c
> index 84831eecc..b55d8547f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -7,7 +7,7 @@
>  void serial_test_wq(void)
>  {
>  	struct wq *wq_skel =3D NULL;
> -	int err, prog_fd;
> +	int err, prog_fd, tries;
>
>  	LIBBPF_OPTS(bpf_test_run_opts, topts);
>
> @@ -28,7 +28,13 @@ void serial_test_wq(void)
>  	ASSERT_OK(err, "test_run");
>  	ASSERT_EQ(topts.retval, 0, "test_run");
>
> -	usleep(50); /* 10 usecs should be enough, but give it extra */
> +	/* loop check over 1 sec to make sure it doesn't fail early when busy *=
/
> +	for (tries =3D 1000; tries >=3D 0; tries--) {
> +		if (wq_skel->bss->ok_sleepable =3D=3D (1 << 1))
> +			break;
> +
> +		usleep(1000);
> +	}
>

Please figure out the actual condition this loop is trying to wait for and
establish it directly, there are several examples in the selftests.

pw-bot: cr
