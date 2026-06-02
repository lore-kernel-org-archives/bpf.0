Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D353A48DF
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427223; cv=fail; b=oQU7T3XrIGpEro5OGzoS79G4rPxJoa4vkBGZm/wMI3fIqFOPHHJwIA53z5nb5O0gWxNic9D2z95eS/UPj+kaLMV6pVtge8qIpKAUg0i2GcLa4JHzeMsrpnC98W9l3hEIVZ3YB0pqtzzJ08cWB8qlZuOa+hON/BymKUdU4RZYU8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427223; c=relaxed/simple;
	bh=PchiZHbJted883YM7Tsx4MCanuIBbvFzBfb6R7sdrLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uc+n3j5Gbv4ABn8Qs1S9btEcbF18zUKuqN6oJI1r6cP+bj2tmHzJHkEcYXmxps1ixww8YcjLrA5MRWMVvMJzZOfoHfmxb9HL8KG4WjykM5NCI4X0mfVGE3/txAXW2VCOPwVRkd/yw6XyZazThuqhxrjqidT98aRz2IUqFo9UeIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jDY90QfF; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jDY90QfF"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652DHBLr1816837
	for <bpf@vger.kernel.org>; Tue, 2 Jun 2026 12:07:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=AmdQqVczB19sGPldwgj6uwVjXHVUoAPkK4whM3xvMNM=; b=jDY90QfF/s6g
	fk1kSwdakA2kyRatMGd5fXtiCwXtbKpXtPrggdCmTCU/5xXBhb/ALSCktzJKFzhg
	x59KnhFGSJRROfNHqUx73LpxJLa5z0T2xcwwbZjmCCWkdKxXJTwcR7sopaMSbAhP
	R1eUiexPqWZi9XiS/QR2A0GIfoiXLkfQNRzGG45HeaAV2+yym/NbHznSDRXetfzc
	psTmX7drT0+T8HaK1VX9g/39Qf6zY/VLeKRyOUuq/8UIHPbj9wfauh1YpBkcviZs
	RVTZUscLbU6Pr/z0MVl3NqiD5Bezz1FeFitWXS3roU9WfPtb6lrEmxXKepd8NoKG
	2PwViZfK3w==
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ehyx2tet5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 12:06:59 -0700 (PDT)
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bec441e4052so276862366b.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 12:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780427218; cv=none;
        d=google.com; s=arc-20240605;
        b=KrKWumtlwe5FKZfCsrVFljj+pvcf9MvSFN+Vy5nlw/66IliJPpZ+5N4MEgGp+Rl7dC
         BdwQvIrMJZlasA5W+Dhk6UHxJa+q5h8lENA0qQxWqlGQxMzyOP/m9NL5MaQOgEltqzKt
         RP+n3u7P9UIvuXCWQMQGTJFoGXF32e75msERM8mM+pMUZ+EDoxaign/qj8tGJbjJFFG9
         yj8ICs98UCa5ve4k86H7P7hrR9yu80Ao8tesSY6icqAJp543GBOFtSPXfCn6pNh1Fkjk
         SOMgbr9zluK95mnyhYZghrmfNTYzQYSZsaEwt2HDn2BNhK2H0+pKu2aa5p8ny53zya/4
         83gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ffyFo/iBrLC5gQgtLpPm5hjGbuSJyPD78waGPloq+jw=;
        fh=OgTpOg/8RMaUDUSDGWwkf2e9CZwHO1A43msHwzMQMQ0=;
        b=S18HMxIBJcDEhF7qwcJHbv35akKxt+ZDbx91lcwwV7LDvnYP0+y82EmZtJIystbZ8D
         WgNgpMRGiu1l6NlQ8HHSHQYNOsejcFSWtdf+nyjct+025+m9KiZ21BpRcSEQugMj9h7l
         mnQSFKKh6ZVLGkPN5n72IUUxDpz0H95qyr5emFWTmQZ6crDaXo+9UTZVwN4/7mqx8NIJ
         cJvtO5SD+jy98yzh5oQO7P8mQGFSHm4s9+HyqIltY/0dcy9K6QBAr6COkrObV+pK6WfN
         LjO4EBB5m5riEwAqpeD74yeXvTkYq8maHAWqSTqXThCLnyRrG7rXt8FqG9z6CcF2Wwbp
         lDuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780427218; x=1781032018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ffyFo/iBrLC5gQgtLpPm5hjGbuSJyPD78waGPloq+jw=;
        b=kS0ibd8SekgiPx4Du8pXlmzJjJeUohc1JQIpNVxG2mTvKRjQLaeElCIXwGqZq5C3vY
         tE9wVd730hLNwScSutzHhSYDc62W24cxogN0Z53+QgKPPSHzBLhDbpmMmrQwcRmaMOjL
         XNqye8aJMfnNjMZq5GJi9jZtugQCFqo3vSc8+zUzjt6UAOsX87O1eynR4MON7Uwh40v7
         sgpukcY7p0hcISRgef5otE3JVdCvtHmdTQwsumCnqT7VPHlj+qwvNgsJoix62c23QMz8
         qBFdYC7mtavAYLe6tUl5cAL/RUkF/Z4U3bWqsOfHP8nPpX/pf63YpccPjM+q1Yj4WO++
         T6aA==
X-Forwarded-Encrypted: i=1; AFNElJ8CLiFdOu8piS9Xon5aKBvQvwO5TseNq3VS6/ILwBlKSKf7CH07DSWhDqgkRruHxZniO40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdAFCiWykeG/d6w95Q50uwMmdNttnIkR5q7it06P1M6439hbju
	F26mTJAvE1ggT66QDw+zzM+qj2QXeh8Zfljz1guxgs5w2A16QTNqEz6oN16T9AGyuBCoLX6BhB8
	C3uYIa3baChg3gTmCU26XpyWWQKkNnFRcuj4/1yOfUxVIzvtbKMl75zadiQOiliWChcvS3bTKdS
	Szr5Ax+e2PBV4JmJJbBZPW1sUsMg==
X-Gm-Gg: Acq92OFBArKldcJem4TSzQ3M7hQGY1QeeNWTFBTF50zWCS6QXmDd87043nq05/PmbQZ
	hFQdXaD1jlZR6a3rYL3B38NaXfPNxj2wmpBc7X6HEmYneKFPrRqfA8dm7KJJF5FRsIyWz4r7Un1
	Ax8pMn/a8nSPly/6oU9Tmu3/KBi75lLMaJe7yea5XE0XSswfci0Mo+XEh+De7sqXBsKDPhO7tl6
	sM2HRM6KTnI5pYiwQ==
X-Received: by 2002:a17:907:fd8b:b0:bd4:7bed:512a with SMTP id a640c23a62f3a-bf061812fd5mr57148166b.30.1780427218288;
        Tue, 02 Jun 2026 12:06:58 -0700 (PDT)
X-Received: by 2002:a17:907:fd8b:b0:bd4:7bed:512a with SMTP id
 a640c23a62f3a-bf061812fd5mr57145066b.30.1780427217854; Tue, 02 Jun 2026
 12:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602181428.2318919-3-ntspring@meta.com> <8ac88be59633fbdf71337c80ecad1a268a989440e8865df3ef6906d33bbf0837@mail.kernel.org>
In-Reply-To: <8ac88be59633fbdf71337c80ecad1a268a989440e8865df3ef6906d33bbf0837@mail.kernel.org>
From: Neil Spring <ntspring@meta.com>
Date: Tue, 2 Jun 2026 12:06:31 -0700
X-Gm-Features: AVHnY4I9E97vtJNAItNoiDOxUpsvUBDTWw2Z8iM1jvir4KetPOYHnRI2Ix4qyAE
Message-ID: <CAGy2EQajXgkqBbYtwCF9qXquHOP7mkLR8MQ+gg-cDjKw+z51KA@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] selftests: net: add local ECMP rehash test
To: bot+bpf-ci@kernel.org
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
        kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
        dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        martin.lau@linux.dev, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
        yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE4NSBTYWx0ZWRfX1hqaYZN0HOvp
 Cmav3xmA9BrSAaV0oVROELsLk9do/VTzA7BmGNZc5Ut7VDbdap+tSbMF8YkjulbBm3MeiRhjhSW
 eBQ0HirhVEkvbQPZQULUju7dwSMJO7D546tHC/oCQ3gHOPbQ/WmurhLJiiN1QGOhqTgUm681gdJ
 jg49ztChu4KpK389SGsF6eCRoNpGrtIJj1xeJ1iwuAat4lx3mX00JiWMjB3FGUFl5mcO04o3C5u
 gsuJ5gmleV7NnnNdzkmupafz/Bx455jJ0OJRv6RGc1VyJW7FwgrCQntczeNw8PFHHO3bye923v/
 VJqtPFc/vGsWXVg/UJFoGXVMAQx0TDvqlOmnu0eFXRyli5+qA3+4PpV2Hj4m4KsxrdUZvWA9p9E
 a//5qNVfLvPHhgaE55nWidejC7kt9utjdEQ3bKvXOzYqWH05Zi8JqxLdXVi5snq7iDYeQYSZxL1
 +9fmtp8Xb7/Dh7pL86A==
X-Proofpoint-GUID: h3mEpFgOb6Vj5d2djTVgMhWcw2ZVSgaA
X-Proofpoint-ORIG-GUID: h3mEpFgOb6Vj5d2djTVgMhWcw2ZVSgaA
X-Authority-Analysis: v=2.4 cv=EJA2FVZC c=1 sm=1 tr=0 ts=6a1f29d3 cx=c_pps
 a=Ak8bExYEjeps3Jj0Zi+cTQ==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8
 a=2M8aKpgkrPwFO8N7dvUA:9 a=QEXdDO2ut3YA:10 a=IIT_bRn7abC_HnDGr_W6:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01

On Tue, Jun 2, 2026 at 11:43=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> >
> > diff --git a/tools/testing/selftests/net/ecmp_rehash.sh b/tools/testing=
/selftests/net/ecmp_rehash.sh
> > new file mode 100755
> > index 000000000000..ffaacf1d9513
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/ecmp_rehash.sh
> > @@ -0,0 +1,1066 @@
>
> [ ... ]
>
> > +tc_filter_pkt_count()
> > +{
> > +     local ns=3D$1; shift
> > +     local dev=3D$1; shift
> > +
> > +     ip netns exec "$ns" tc -s filter show dev "$dev" parent 1: 2>/dev=
/null |
> > +             awk '/Sent .* pkt/ {
> > +                     for (i=3D1; i<=3DNF; i++)
> > +                             if ($i =3D=3D "pkt") { print $(i-1); exit=
 }
> > +             }'
> > +}
>
> These per-device tc filter counters match all TCP IPv6 traffic on the
> device, with no isolation by port.
>
> [ ... ]
>
> > +test_ecmp_syncookie_path_consistency()
> > +{
>
> [ ... ]
>
> > +     for r in $(seq 1 "$ECMP_REBUILD_ROUNDS"); do
> > +             local port=3D$((PORT + 3 * ECMP_REBUILD_ROUNDS + r))
> > +
> > +             ip netns exec "$NS2" socat -u \
> > +                     "TCP6-LISTEN:$port,bind=3D[fd00:ff::2],reuseaddr"=
 \
> > +                     - >/dev/null &
> > +             local server_pid=3D$!
> > +
> > +             wait_local_port_listen "$NS2" "$port" tcp
> > +
> > +             local srv_base0 srv_base1
> > +             srv_base0=3D$(tc_filter_pkt_count "$NS2" veth0b)
> > +             srv_base1=3D$(tc_filter_pkt_count "$NS2" veth1b)
>
> The baseline is snapshotted here, after the new listener starts, which
> handles leakage that arrives before this point.
>
> [ ... ]
>
> > +             local srv_tcp0 srv_tcp1
> > +             srv_tcp0=3D$(tc_filter_pkt_count "$NS2" veth0b)
> > +             srv_tcp1=3D$(tc_filter_pkt_count "$NS2" veth1b)
> > +             local srv_delta0=3D$(( ${srv_tcp0:-0} - ${srv_base0:-0} ))
> > +             local srv_delta1=3D$(( ${srv_tcp1:-0} - ${srv_base1:-0} ))
> > +
> > +             if [ "$srv_delta0" -gt 0 ] && [ "$srv_delta1" -gt 0 ]; th=
en
> > +                     path_splits=3D$((path_splits + 1))
> > +             fi
> > +
> > +             kill "$client_pid" 2>/dev/null
> > +             wait "$client_pid" 2>/dev/null
> > +             kill "$server_pid" 2>/dev/null
> > +             wait "$server_pid" 2>/dev/null
> > +     done
>
> The client and server from each round are killed at the end of the
> round, but the loop moves straight on to the next round.
>
> Can asynchronous teardown traffic (FIN/RST/ACK) from the killed client
> or server of a previous round still be in flight after srv_base0 and
> srv_base1 are snapshotted for the next round?  Since the counters match
> all TCP IPv6 traffic on the device rather than the current round's port,
> would a late teardown packet on one path plus the new round's traffic on
> the other path increment both srv_delta0 and srv_delta1, satisfying the
> srv_delta0 > 0 && srv_delta1 > 0 check and recording a spurious split?
>
> Would a short quiescence wait or filtering the tc counters by the
> current round's port make this check more robust against late packets?

Yes, thanks; fixed locally and will appear in v12.  Each round now waits fo=
r all
active TCP sockets on the port to close before proceeding to the next round,
preventing late FIN/RST packets from polluting the next round's tc
filter baseline.

> > +     if [ "$path_splits" -gt 0 ]; then
> > +             check_err 1 "$path_splits/$ECMP_REBUILD_ROUNDS had split =
server path"
> > +     fi
>
> The same pattern appears in ecmp_dst_rebuild_loop(), which also relies
> on these global per-device counters across rounds.

This was less of an issue since ecmp_dst_rebuild_loop had a threshold number
of packets that a stray connection termination packet would not reach, but =
the
same wait doesn't hurt.

> This was raised by an automated review on an earlier version
> (v9, https://lore.kernel.org/r/20260530004914.C05121F00898@smtp.kernel.or=
g )
> and the counter structure is unchanged in the current version.  It
> affects test reliability rather than kernel correctness.

Apologies, my error.

-neil

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/268394=
85409
