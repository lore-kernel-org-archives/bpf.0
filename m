Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507BD3BCD37
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335094; cv=none; b=ohdMhtoBaqzJzHeDjvgpfKe7roOOi6bFJMKRTnW0vOqO/qx8PTX7AoaVaietWOAo869pkkZ2SI5XGu/z5tol6oO0rh92uF4A69qWrUKIozidO0tgNiOcCnYpGMa3vQmqSkl0kr2xroctWP3NcnHarsolpHhnuu3K652SUz7gBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335094; c=relaxed/simple;
	bh=He2KYxQxFOYfUvBCEdU6KVIHQ9ioT0lUUIGeFFdbizg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Iwind7PmxegPbOqB6RkYBFiGBnQxx1LNQcWEIarZ81WDUf+ZWcbqvnKYBzikTvxnrWNZMrHbRMhRLD3j3yxrOH7sJ+y8CaF2P3q4yEYprYYx5ZZE7jumghBu/8FyPHVgv4cEXPPvi8RRD8BO5HcVJmccG+XynED4VmPG7bUKfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=WqmfHoR5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="WqmfHoR5"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so840594a91.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788335093; x=1788939893; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dF0J1p4zzUo0oOMD9z+s+iaA8fp2BSZeTfe7CbtsAi8=;
        b=WqmfHoR5MEd5/ZsaDMYxaPFgLp6YlsFopcaNdJkc3TXij+7V+TQRm/1NLC93j8YCq3
         lGQIQFihnIZJIWFDABRbZktrDTYgkIN6h6/0NKLfCYp/uHp9e08e2l9rZoyjOMSpZFzp
         a23kh4sSffEHd/t9VgL+MvU6/9BLMCe1l/TVPm1jPTWsY5NfCLrq7bmZafvQpoD7jiRM
         rrFUMBkoUNLj9E2EjECTdU2sxqyZw8xYx4b4jfPmFLEFsVyBuc7aGlrbfvy072ou8kAB
         f+07QypL4f/o4OHsBZjCYk7KbO5HkTJaZ5DG+/l++JpOplv5vKSeAxn/3T96upVPcPbK
         aEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788335093; x=1788939893;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dF0J1p4zzUo0oOMD9z+s+iaA8fp2BSZeTfe7CbtsAi8=;
        b=P12R/IyFuih4wkMT2q095RdzOzz9Gu7A3+Mh6m/ZAF/pxuASBDBzFfOUIoIy3sy04w
         X5JMdgSOxC4aT0p6FaGKkzGTZ91MXnSMRQkxczetQPK+usfgPt3F4l6jBwAnNaFGmDW2
         FJ/W37jWIVQjc2WBDfCZ48rwmHEYsnbH/ER013B7s9Wj5JUCDHTrjyvBpehY1Eak0wbV
         1HZNEmVRQ/smvGl1LYXBO3U3HDM9Jj2zndqBAOJmE7f5my1lzV7annY1xMNDPgbnAJca
         8+ZrYiVJ+rlkiGp5pWsqwLeckFvsRd81/vvfpvPdcQQdnIWH8OJQWVZsuxo0B21K+ZUQ
         Jtvw==
X-Forwarded-Encrypted: i=1; AKwUvBzdBALPJD74YQQiXllqrVKN2ALuiR/yRHraIArgUnvVImAR0zaNGZ5VwZsDhIKxPV/FSWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++leKQnVi7rPkSlYGms43/cwFEla8F+bsnFQnPNYetekrNtseK84
	xs7SZVebgQdOHCacu9Mpw/bKtXmBbdEaSON6ACsi2x7LR9x5xlV4caxZOhpSERV1rRA=
X-Gm-Gg: AYBFou27OKxhdE6j+fqYlfsh0ritTy7w898XCBm8xR2xBttblwswL4LCU5tHqjehEJ3
	BlUW3sEOqLt1lG0YFkFIa4+IztAhbpuvyTrYlEXYE9+lkWPbkbkovutN4zuY6FhOhaymccEKH7y
	Xhn2TtLnxPcRIcFMp8wmedFisMl2jqaztxPsv5AYA/c4JtEp8lcZ7UVTPL+p17pOQjCG7jmFbF0
	iZz7+MdB9+TPSHuaZ6K2tTgoU0tVeRLctFr13LV5gE9DyICuwIIbBEFTxS6MfgkHzFBlOSxxii5
	CvbCqcrooiWeUvpfIg7GA+UEuRuR7tm9k5Z3Ull7vVrNIoz55tF3nt9ylAHtW99bGNX97zJRyR7
	MkkPRa0JMpV/DRm1ITjM5p/QtUcmG/MW4RfUdWcWm70X7cdEIU+bJBv765ku6x+hwWCj7XNyljN
	sdzlEFGVS6HVrEXCz+6jxdI9oF6mFRHHT4VPUheAIBFe1GfEXeSXnEVdg/L2sKio87mWacyBMTA
	utKH7OrEwf439tWwePx5WW6yXS+
X-Received: by 2002:a17:90b:2f84:b0:398:9bd3:d6d1 with SMTP id 98e67ed59e1d1-39af64e0adbmr1032593a91.11.1788335092395;
        Wed, 02 Sep 2026 00:44:52 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d463798sm9938748a91.6.2026.09.02.00.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 00:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 03:44:50 -0400
Message-Id: <DL4NVR5IIKSE.IC903DOR6ZDA@etsalapatis.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Jiayuan
 Chen" <jiayuan.chen@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Track test_xdp_features DUT
 processes
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Bochao Cao" <bochaolucky@gmail.com>, =?utf-8?q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-xdp-dut-process-lifecycle-gmail-v2-1-b03ef2aa1b97@gmail.com> <d4be160e-703e-46bb-9509-d3d90f6bc34b@iogearbox.net> <DKX99ZAP7GZ8.23U5EOSFB4VPU@bootlin.com> <CAHKNYVXN0DAUzv2Lwm=oQ_K=zhi2iNyTO2e99s5F4M+Kr7u5tQ@mail.gmail.com> <CAHKNYVV8gn-L_unjsxUZV=E+Rx4ouDBJX613_n4hevXP1rivyg@mail.gmail.com> <CAHKNYVX_r_yS+NjkTx=gn7zGfcHF11azQbFWHJ+naqXO3aTpJw@mail.gmail.com>
In-Reply-To: <CAHKNYVX_r_yS+NjkTx=gn7zGfcHF11azQbFWHJ+naqXO3aTpJw@mail.gmail.com>

On Fri Aug 28, 2026 at 5:32 AM EDT, Bochao Cao wrote:
>  Resending as plain text because my previous reply was rejected by the
> vger mailing lists. Sorry for the duplicate.
>  Thanks Daniel and Alexis.
>
>   Dropping the procps dependency is not the primary motivation for
>   this change. I agree that Debian can remove the dependency independentl=
y.
>   The issue addressed by this patch is process isolation in the standalon=
e
>   test. The current readiness check may observe an unrelated
>   concurrent xdp_features process, while cleanup may terminate every
> xdp_features
>   process on the host. In addition, a DUT which exits before listening
> can leave the test waiting indefinitely.
>
>   Although this script is not currently run by the BPF CI, it remains
> useful  for testing real hardware,
>   so these process lifecycle issues can still  affect users running
> the test manually.
>
>   Would it be acceptable to fix these issues in the script's current loca=
tion?
>   If the preferred direction is to move it under
> tools/testing/selftests/drivers/net/hw/,
>   should the move be submitted first, with this fix rebased on top?
>
>   I can send a v3 that drops the Debian Closes tag and focuses
>   the commit message solely on the process isolation, timeout,
>   and cleanup fixes once the preferred location is clear.
>
>   Thanks,
>   Bochao

While I'd defer to Daniel and Alexis on this, imo we could merge the fix
as-is and move the file as a followup since the change is a net gain on
its own.

Wherever we end up putting the file feel free to add:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
>
> Bochao Cao <bochaolucky@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 14:10=E5=86=99=E9=81=93=EF=BC=9A
>>
>>  Thanks Daniel and Alexis.
>>
>>   Dropping the procps dependency is not the primary motivation for
>>   this change. I agree that Debian can remove the dependency independent=
ly.
>>   The issue addressed by this patch is process isolation in the standalo=
ne
>>   test. The current readiness check may observe an unrelated
>>   concurrent xdp_features process, while cleanup may terminate every xdp=
_features
>>   process on the host. In addition, a DUT which exits before listening c=
an leave the test waiting indefinitely.
>>
>>   Although this script is not currently run by the BPF CI, it remains us=
eful  for testing real hardware,
>>   so these process lifecycle issues can still  affect users running the =
test manually.
>>
>>   Would it be acceptable to fix these issues in the script's current loc=
ation?
>>   If the preferred direction is to move it under tools/testing/selftests=
/drivers/net/hw/,
>>   should the move be submitted first, with this fix rebased on top?
>>
>>   I can send a v3 that drops the Debian Closes tag and focuses
>>   the commit message solely on the process isolation, timeout,
>>   and cleanup fixes once the preferred location is clear.
>>
>>   Thanks,
>>   Bochao
>>
>> Bochao Cao <bochaolucky@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=BA=8C 21:01=E5=86=99=E9=81=93=EF=BC=9A
>> >
>> >   Thanks Daniel and Alexis.
>> >
>> >   Dropping the procps dependency is not the primary motivation for
>> >   this change. I agree that Debian can remove the dependency independe=
ntly.
>> >   The issue addressed by this patch is process isolation in the standa=
lone
>> >   test. The current readiness check may observe an unrelated
>> >   concurrent xdp_features process, while cleanup may terminate every x=
dp_features
>> >   process on the host. In addition, a DUT which exits before listening=
 can leave the test waiting indefinitely.
>> >
>> >   Although this script is not currently run by the BPF CI, it remains =
useful  for testing real hardware,
>> >   so these process lifecycle issues can still  affect users running th=
e test manually.
>> >
>> >   Would it be acceptable to fix these issues in the script's current l=
ocation?
>> >   If the preferred direction is to move it under tools/testing/selftes=
ts/drivers/net/hw/,
>> >   should the move be submitted first, with this fix rebased on top?
>> >
>> >   I can send a v3 that drops the Debian Closes tag and focuses
>> >   the commit message solely on the process isolation, timeout,
>> >   and cleanup fixes once the preferred location is clear.
>> >
>> >   Thanks,
>> >   Bochao
>> >
>> > Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> =E4=BA=8E2026=E5=B9=
=B48=E6=9C=8824=E6=97=A5=E5=91=A8=E4=B8=80 22:49=E5=86=99=E9=81=93=EF=BC=9A
>> >>
>> >> Hi Daniel, thanks for the notification
>> >>
>> >> On Mon Aug 24, 2026 at 1:31 PM CEST, Daniel Borkmann wrote:
>> >> > [ Trimming the excessive Cc list, and adding Alexis ]
>> >> >
>> >> > On 8/12/26 10:28 AM, Bochao Cao via B4 Relay wrote:
>> >> >> From: Bochao Cao <bochaolucky@gmail.com>
>> >> >>
>> >> >> test_xdp_features.sh waits for any xdp_features listener to appear=
 and
>> >> >> uses pidof during cleanup. A concurrent test can therefore make an=
other
>> >> >> test proceed before its own DUT is ready, and cleanup kills every
>> >> >> xdp_features process on the host. The readiness loop also has no t=
imeout,
>> >> >> so a DUT that exits before listening leaves the test hung indefini=
tely.
>> >> >>
>> >> >> Track one active DUT at a time, wait for ss to report that exact P=
ID with
>> >> >> a bounded retry loop, and reap it after each test. Consult the she=
ll job
>> >> >> table before signaling the DUT so a stale PID cannot target an unr=
elated
>> >> >> process. On failure, terminate the shell job with SIGKILL and reap=
 it so
>> >> >> blocked I/O cannot hang cleanup. Install an EXIT trap and signal h=
andlers
>> >> >> so failure paths also remove network setup.
>> >> >>
>> >> >> Fixes: 4dba3e7852b7 ("selftests/bpf: introduce XDP compliance test=
 tool")
>> >> >> Closes: https://bugs.debian.org/1136522
>> >> >> Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
>> >> >> ---
>> >> >> Tests:
>> >> >> - bash -n tools/testing/selftests/bpf/test_xdp_features.sh
>> >> >> - make -C tools/testing/selftests/bpf xdp_features
>> >> >> - sudo tools/testing/selftests/bpf/test_xdp_features.sh
>> >> >> - verified cleanup terminates a blocked DUT without affecting an u=
nrelated process
>> >> >> ---
>> >> >> Changes in v2:
>> >> >> - Clarify that avoiding name-wide process matching, rather than dr=
opping a dependency, is the motivation.
>> >> >> - Track and reap one active DUT at a time instead of retaining his=
torical PIDs.
>> >> >> - Address PID reuse by signaling only the current Bash job during =
cleanup.
>> >> >> - Use SIGKILL on failure cleanup so blocked DUT I/O cannot hang wa=
it indefinitely.
>> >> >> - Link to v1: https://patch.msgid.link/20260805-xdp-dut-process-li=
fecycle-gmail-v1-1-45984df8d295@gmail.com
>> >> >> ---
>> >> >>   tools/testing/selftests/bpf/test_xdp_features.sh | 82 ++++++++++=
++++++++------
>> >> >>   1 file changed, 62 insertions(+), 20 deletions(-)
>> >> >
>> >> > Sorry for the late reply. With regards to https://bugs.debian.org/1=
136522, src:linux deb
>> >> > does not have to depend on this at all, so the src:linux can just g=
et rid of procps in
>> >> > any case if this is indeed the last dependency. I'm not seeing the =
test being run in our
>> >> > BPF CI. I've Cc'ed Alexis as he's in the process of migrating and/o=
r removing tests from
>> >> > tools/testing/selftests/bpf/ depending on how they fit into test_pr=
ogs framework. I'll
>> >> > let him comment if there is already work in progress. It feels like=
 this script could be
>> >> > reworked into tools/testing/selftests/drivers/net/hw/ tests and rem=
oved altogether from
>> >> > the tools/testing/selftests/bpf/ dir.
>> >>
>> >> There has been an attempt to fully convert and get rid of
>> >> test_xdp_features.sh, but discussions around the corresponding series
>> >> highlighted the need for the script to remain available for testing o=
n
>> >> real hardware.  Features covered by the test_xdp_features.sh that wer=
e
>> >> not covered yet by test_progs have been added to test_progs (in
>> >> xdp_cpumap_attach), see [1]. So there's currently no active effort on
>> >> this one on my side.
>> >>
>> >> Alexis
>> >>
>> >> [1] https://lore.kernel.org/bpf/20241009-convert_xdp_tests-v3-0-51cea=
913710c@bootlin.com/
>> >>
>> >> --
>> >> Alexis Lothor=C3=A9, Bootlin
>> >> Embedded Linux and Kernel engineering
>> >> https://bootlin.com
>> >>

