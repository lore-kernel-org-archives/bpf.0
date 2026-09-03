Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE823A16BC
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423042; cv=pass; b=L3F+IPBAjSb3nvaeBZj0hWQTLDgYyh/kVy65Pd/6RZBJ1Oom4UJS7NSVlWXRhW4zyNeTLxl/SB8XxpSmhxThJw1MaV8+WP7fkid4zQh9nKeDfWABcKntYjQJd+8nyvtE1LVqnWSy9imWUTGnwJHhuZfS64KYL5TiyjGfMeTfdIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423042; c=relaxed/simple;
	bh=Ri1nuWgBzlWKmVgcPTEh7t/O9jzz9QoV3TsIc1HvvfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8e2ObrSjBN1kgL5aoQYJ2pYx8DEXLj5LGGCsmpmKpQ6vWxBmZdgcOxEL++zkIxaa5sAQeJY3RVPwXGN8o1qmF0ETP9WYUhbuaM5g497m7CCbhYta7z2DwIdVsLn7ntT1RQL+QX6mHww5gZDhJhG8ENRTs96iOVzQBJC3OdTVvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcR2zzjI; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcR2zzjI"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-87005a0e052so1193707b3.2
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 01:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788423039; cv=none;
        d=google.com; s=arc-20260327;
        b=a6K91Fxu5Q/4BLhWMREREE5E8w/2cAcmoy9e+w1vLlQUTwN7khbv4g/mOF7ZIhYXSe
         4jjwCbJpLIEYbx4a0ErmELVj9X6zK/tDL59re5p66YhTrjXpa0musSYm7tUZYbNTC8VF
         P6TMobz8mAb/VUVXtJpBo0vb0KPXXGctfId7Fy2iW93xNrvAP5QZW9gg25TPghUr5AC1
         qNJm0ujbPcE3g4kdG7J4/+iU0ngq8et0dhjaZWGbAyHOaie686p1eyw7Zt311pPjFJio
         mwod+OjVRVsqTJz6b0bi0gA+57dFUTJ4ShR9WO4OMrowJBYyzNUUbC+QkGufgcgKKOrb
         5aTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RAkLwpKGEZf+fAIaSu+wznOfKXRcrs45lnuC3CrX6bc=;
        fh=QNEQhFWah0ycUi8cQXAA+3m09VMw1+wwpxlBOW6Uh1Q=;
        b=CfZ70gNxD4EqHN6Mh85hsqDqUH68WowueHMY+L78vpfRtpHyuTpYSgLYOsE8QAFoV2
         AYsMpTkNlKAuwAezEzG68f/zU/+1OOy64ovutCGXesrOaLEvKBDSZgpHKZMa4SybqdUw
         Xsw12LhYUU9Vht0uvxk0lRmgwX5Z9RsVFaPjjESaejLFi+8mNfFNixXQXt2rS2lO9hae
         S1xfq+GURRVk3RSTYShKib6j2Fru+442lsvyYz4+vvRXw/1L9mruaCR91Sih1WygwDnC
         ked9QeIz+ITlw/9rtfXkWpJVSOn/lSLKzMUGm0f8TeX4jDzJpaT43+GXlqXNeRsBW3hO
         2MEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788423039; x=1789027839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RAkLwpKGEZf+fAIaSu+wznOfKXRcrs45lnuC3CrX6bc=;
        b=LcR2zzjIv2x4YVoqkAVRomcXZRAjg0izLiKxxMQmdKCCxXVR97+sBfyqzUTzsEHdhl
         EMFj5aIqVCMkmQ4U6wjzE5MfqM0P/Y4Zd9xYT3PSJ6WQJ8+XcbjxFeRVs+gPW+1UXB4e
         lxqL0Q66O64xFvumAfjMy5cyc2gejLWcb78fTiM61vaDRNEpTs4ZzRKA4iNFnk3ehowz
         l4QINfv4VYbAuyWSq0MgxzbgboreG59nsl5ThQJ9njF+d93SGnbPV/l7URweDqtk6Yii
         TY677a+l/CsNMMMB2riOQiuz+bD2pU3NniEaZfnpXv5ZYuoYqC7Z05Moe4cjRHPeL0E3
         jgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788423039; x=1789027839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RAkLwpKGEZf+fAIaSu+wznOfKXRcrs45lnuC3CrX6bc=;
        b=FzUIWWPygMZPoWou9va0O83/+k3/5xZ04gUezc/vgu9GYCQhWUE/ad/OUKUcRiXFeR
         D57E0DKmIPvPaeIa74hw3VMjC78cwpMN08F+H47/TQYngIw37Rdc2qql0V42TCX8okBI
         CiXCXKwmSNJTGw4oUHtnKokiFSQamdKLB4fyeaYAG5f0dtBWxoTt3/BWYyWyu5nPKX6C
         HgGpIR/Yfe85JJ15gvyue6xtKx4FLpsq8iyBEFaIZyb8eoB3XMfXyCbgSktQIeKG4d3s
         f+Mp4miiP//0bWRNRknfLOfF6NGf2DrkZW31sTGP2z9Ufh3VmifSGRP/6HFs8T64tgYY
         0hyA==
X-Forwarded-Encrypted: i=1; AKwUvBw0bcA9d/UxKvItdHzIpEzsMjHpSgQ7jFPeTWFeXweslbMd2ShAT+DJuj08TnvTRzw865w=@vger.kernel.org
X-Gm-Message-State: AFuF++l5RMiNmUXg+xZ93Z50SBEnnjRKJpQQbpMLRn5l1GS8xMXWij6x
	hWmZ/hdqUtJQnzHB+nv/LLo1i952qnz0Lz9MLOP1jZq2QUCIp740Fa9/a/NHbRBnG2gO2JGE3rz
	oJmZxmoNqj0jtvoE3noxLD8W52owHd/I=
X-Gm-Gg: AYBFou2St1V7QTXOFHmluyYXahRoabWccG7sG3jK8KwvFhjGBv2ktweAbksy2BODOB6
	WAdpgkyUh3w8zlVDMXU7UFK4KjRSWgneW7n+uxLFLGdlCICNEhzyFm4kM9JkGdFY3WolojnhpOp
	XlzoxEF278PUClPwBcFsNRYc48aBu1aeWOmHvabmaqwJsLGAhRq0tlKcPzRVVBfFylk+s76duko
	C62hsoMFLi9YDzS9t8ZMLkQJBaUF6A+/sh1zcBx9cem2fnJBFm4kjqcj7tS0msiuxAOwX7n0El2
	gOC+AzoZvnGbB++fs6IBGmQ5o1OT2d6H11YMbmzkOpps
X-Received: by 2002:a05:690c:4ad7:b0:869:adba:625b with SMTP id
 00721157ae682-86c53393f40mr38386797b3.25.1788423039335; Thu, 03 Sep 2026
 01:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812-xdp-dut-process-lifecycle-gmail-v2-1-b03ef2aa1b97@gmail.com>
 <d4be160e-703e-46bb-9509-d3d90f6bc34b@iogearbox.net> <DKX99ZAP7GZ8.23U5EOSFB4VPU@bootlin.com>
 <CAHKNYVXN0DAUzv2Lwm=oQ_K=zhi2iNyTO2e99s5F4M+Kr7u5tQ@mail.gmail.com>
 <CAHKNYVV8gn-L_unjsxUZV=E+Rx4ouDBJX613_n4hevXP1rivyg@mail.gmail.com>
 <CAHKNYVX_r_yS+NjkTx=gn7zGfcHF11azQbFWHJ+naqXO3aTpJw@mail.gmail.com> <DL4NVR5IIKSE.IC903DOR6ZDA@etsalapatis.com>
In-Reply-To: <DL4NVR5IIKSE.IC903DOR6ZDA@etsalapatis.com>
From: Bochao Cao <bochaolucky@gmail.com>
Date: Thu, 3 Sep 2026 16:10:01 +0800
X-Gm-Features: AcwNN1W8zo3HUntwWLr6xgG9tqUYq1Z6AYfTZ41NEPBEx_muIqXDrBLxpFt8tzc
Message-ID: <CAHKNYVXFB5aFBNU5-__TsVNNX2ket7TO1EB-HcX1FgJhbKeVCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Track test_xdp_features DUT processes
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Thanks Daniel, Alexis, and Emil.

  Moving the test to tools/testing/selftests/drivers/net/hw/ appears to
  require more than relocating the shell script. The xdp_features userspace
  tool, BPF program, skeleton build rules, and test environment would also
  need to be adapted to the net driver selftest framework.

  Would it be acceptable to take the process lifecycle fix as a v3 in its
  current location, followed by a separate migration series?

  I would also be happy to work on the migration. If you would prefer to
  see the migration before this fix is applied, I can prepare v3 as a
  small series, keeping the framework migration and the process lifecycle
  changes separate where practical.

  Thanks,
  Bochao

Emil Tsalapatis <emil@etsalapatis.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 15:44=E5=86=99=E9=81=93=EF=BC=9A


Emil Tsalapatis <emil@etsalapatis.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 15:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri Aug 28, 2026 at 5:32 AM EDT, Bochao Cao wrote:
> >  Resending as plain text because my previous reply was rejected by the
> > vger mailing lists. Sorry for the duplicate.
> >  Thanks Daniel and Alexis.
> >
> >   Dropping the procps dependency is not the primary motivation for
> >   this change. I agree that Debian can remove the dependency independen=
tly.
> >   The issue addressed by this patch is process isolation in the standal=
one
> >   test. The current readiness check may observe an unrelated
> >   concurrent xdp_features process, while cleanup may terminate every
> > xdp_features
> >   process on the host. In addition, a DUT which exits before listening
> > can leave the test waiting indefinitely.
> >
> >   Although this script is not currently run by the BPF CI, it remains
> > useful  for testing real hardware,
> >   so these process lifecycle issues can still  affect users running
> > the test manually.
> >
> >   Would it be acceptable to fix these issues in the script's current lo=
cation?
> >   If the preferred direction is to move it under
> > tools/testing/selftests/drivers/net/hw/,
> >   should the move be submitted first, with this fix rebased on top?
> >
> >   I can send a v3 that drops the Debian Closes tag and focuses
> >   the commit message solely on the process isolation, timeout,
> >   and cleanup fixes once the preferred location is clear.
> >
> >   Thanks,
> >   Bochao
>
> While I'd defer to Daniel and Alexis on this, imo we could merge the fix
> as-is and move the file as a followup since the change is a net gain on
> its own.
>
> Wherever we end up putting the file feel free to add:
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> >
> >
> > Bochao Cao <bochaolucky@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 14:10=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>  Thanks Daniel and Alexis.
> >>
> >>   Dropping the procps dependency is not the primary motivation for
> >>   this change. I agree that Debian can remove the dependency independe=
ntly.
> >>   The issue addressed by this patch is process isolation in the standa=
lone
> >>   test. The current readiness check may observe an unrelated
> >>   concurrent xdp_features process, while cleanup may terminate every x=
dp_features
> >>   process on the host. In addition, a DUT which exits before listening=
 can leave the test waiting indefinitely.
> >>
> >>   Although this script is not currently run by the BPF CI, it remains =
useful  for testing real hardware,
> >>   so these process lifecycle issues can still  affect users running th=
e test manually.
> >>
> >>   Would it be acceptable to fix these issues in the script's current l=
ocation?
> >>   If the preferred direction is to move it under tools/testing/selftes=
ts/drivers/net/hw/,
> >>   should the move be submitted first, with this fix rebased on top?
> >>
> >>   I can send a v3 that drops the Debian Closes tag and focuses
> >>   the commit message solely on the process isolation, timeout,
> >>   and cleanup fixes once the preferred location is clear.
> >>
> >>   Thanks,
> >>   Bochao
> >>
> >> Bochao Cao <bochaolucky@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8825=
=E6=97=A5=E5=91=A8=E4=BA=8C 21:01=E5=86=99=E9=81=93=EF=BC=9A
> >> >
> >> >   Thanks Daniel and Alexis.
> >> >
> >> >   Dropping the procps dependency is not the primary motivation for
> >> >   this change. I agree that Debian can remove the dependency indepen=
dently.
> >> >   The issue addressed by this patch is process isolation in the stan=
dalone
> >> >   test. The current readiness check may observe an unrelated
> >> >   concurrent xdp_features process, while cleanup may terminate every=
 xdp_features
> >> >   process on the host. In addition, a DUT which exits before listeni=
ng can leave the test waiting indefinitely.
> >> >
> >> >   Although this script is not currently run by the BPF CI, it remain=
s useful  for testing real hardware,
> >> >   so these process lifecycle issues can still  affect users running =
the test manually.
> >> >
> >> >   Would it be acceptable to fix these issues in the script's current=
 location?
> >> >   If the preferred direction is to move it under tools/testing/selft=
ests/drivers/net/hw/,
> >> >   should the move be submitted first, with this fix rebased on top?
> >> >
> >> >   I can send a v3 that drops the Debian Closes tag and focuses
> >> >   the commit message solely on the process isolation, timeout,
> >> >   and cleanup fixes once the preferred location is clear.
> >> >
> >> >   Thanks,
> >> >   Bochao
> >> >
> >> > Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> =E4=BA=8E2026=E5=B9=
=B48=E6=9C=8824=E6=97=A5=E5=91=A8=E4=B8=80 22:49=E5=86=99=E9=81=93=EF=BC=9A
> >> >>
> >> >> Hi Daniel, thanks for the notification
> >> >>
> >> >> On Mon Aug 24, 2026 at 1:31 PM CEST, Daniel Borkmann wrote:
> >> >> > [ Trimming the excessive Cc list, and adding Alexis ]
> >> >> >
> >> >> > On 8/12/26 10:28 AM, Bochao Cao via B4 Relay wrote:
> >> >> >> From: Bochao Cao <bochaolucky@gmail.com>
> >> >> >>
> >> >> >> test_xdp_features.sh waits for any xdp_features listener to appe=
ar and
> >> >> >> uses pidof during cleanup. A concurrent test can therefore make =
another
> >> >> >> test proceed before its own DUT is ready, and cleanup kills ever=
y
> >> >> >> xdp_features process on the host. The readiness loop also has no=
 timeout,
> >> >> >> so a DUT that exits before listening leaves the test hung indefi=
nitely.
> >> >> >>
> >> >> >> Track one active DUT at a time, wait for ss to report that exact=
 PID with
> >> >> >> a bounded retry loop, and reap it after each test. Consult the s=
hell job
> >> >> >> table before signaling the DUT so a stale PID cannot target an u=
nrelated
> >> >> >> process. On failure, terminate the shell job with SIGKILL and re=
ap it so
> >> >> >> blocked I/O cannot hang cleanup. Install an EXIT trap and signal=
 handlers
> >> >> >> so failure paths also remove network setup.
> >> >> >>
> >> >> >> Fixes: 4dba3e7852b7 ("selftests/bpf: introduce XDP compliance te=
st tool")
> >> >> >> Closes: https://bugs.debian.org/1136522
> >> >> >> Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
> >> >> >> ---
> >> >> >> Tests:
> >> >> >> - bash -n tools/testing/selftests/bpf/test_xdp_features.sh
> >> >> >> - make -C tools/testing/selftests/bpf xdp_features
> >> >> >> - sudo tools/testing/selftests/bpf/test_xdp_features.sh
> >> >> >> - verified cleanup terminates a blocked DUT without affecting an=
 unrelated process
> >> >> >> ---
> >> >> >> Changes in v2:
> >> >> >> - Clarify that avoiding name-wide process matching, rather than =
dropping a dependency, is the motivation.
> >> >> >> - Track and reap one active DUT at a time instead of retaining h=
istorical PIDs.
> >> >> >> - Address PID reuse by signaling only the current Bash job durin=
g cleanup.
> >> >> >> - Use SIGKILL on failure cleanup so blocked DUT I/O cannot hang =
wait indefinitely.
> >> >> >> - Link to v1: https://patch.msgid.link/20260805-xdp-dut-process-=
lifecycle-gmail-v1-1-45984df8d295@gmail.com
> >> >> >> ---
> >> >> >>   tools/testing/selftests/bpf/test_xdp_features.sh | 82 ++++++++=
++++++++++------
> >> >> >>   1 file changed, 62 insertions(+), 20 deletions(-)
> >> >> >
> >> >> > Sorry for the late reply. With regards to https://bugs.debian.org=
/1136522, src:linux deb
> >> >> > does not have to depend on this at all, so the src:linux can just=
 get rid of procps in
> >> >> > any case if this is indeed the last dependency. I'm not seeing th=
e test being run in our
> >> >> > BPF CI. I've Cc'ed Alexis as he's in the process of migrating and=
/or removing tests from
> >> >> > tools/testing/selftests/bpf/ depending on how they fit into test_=
progs framework. I'll
> >> >> > let him comment if there is already work in progress. It feels li=
ke this script could be
> >> >> > reworked into tools/testing/selftests/drivers/net/hw/ tests and r=
emoved altogether from
> >> >> > the tools/testing/selftests/bpf/ dir.
> >> >>
> >> >> There has been an attempt to fully convert and get rid of
> >> >> test_xdp_features.sh, but discussions around the corresponding seri=
es
> >> >> highlighted the need for the script to remain available for testing=
 on
> >> >> real hardware.  Features covered by the test_xdp_features.sh that w=
ere
> >> >> not covered yet by test_progs have been added to test_progs (in
> >> >> xdp_cpumap_attach), see [1]. So there's currently no active effort =
on
> >> >> this one on my side.
> >> >>
> >> >> Alexis
> >> >>
> >> >> [1] https://lore.kernel.org/bpf/20241009-convert_xdp_tests-v3-0-51c=
ea913710c@bootlin.com/
> >> >>
> >> >> --
> >> >> Alexis Lothor=C3=A9, Bootlin
> >> >> Embedded Linux and Kernel engineering
> >> >> https://bootlin.com
> >> >>
>
