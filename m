Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1590348465
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657110; cv=pass; b=KLzUFQjE16OdWbM7XQdGbupgbwqKL8ekw6uhSVqMPM0UaHEMO6t5NUulDRrcIQQOkGdoZ9RFhyBTha+0R0E45QJ6nuZC/CwPu0pumLslZNKxP5ee15Y1L789gBDL9lXviF31U1J1nDIQmWOWh8anQPE9gjAXl6LVdO1cop9NFXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657110; c=relaxed/simple;
	bh=zqgl3pbskrbkTozrwxgbvswniY/xOjGwupQZXrSWh/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uravNANm+PHbK6xV087dx+SepoDk8Kz15d/J4MEFMNF5iWJnmsfLQHyQ90Hekf5CHIeCP8S0wVdJAlK2gdiBbVskVZX8WzsG49ANPjhdlggN8CFP4ds6vbRVn88TmkYQMtDC+UMpAf806stsZ9L6IpYAv0YBiCeJ8Ka5tfKzCkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RM/h7CWX; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RM/h7CWX"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DLZemq2788527
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:38:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=VlrbFOJxXjmsZIn+Tcg7ufa9fCfKXuFTRewOf
	qyQ8t4=; b=RM/h7CWXJtpjCk2kbZ0aNHz0VqUMl7VJxjgjFBuzDeODqQLk7Ye03
	2lxjq9tqjaOKYEknF6g/fRSq2nQrJMrfKA65qYQKJjva5kzSAr5qLEI3usaQNCQg
	C7zQzsaFch66oFB0WmTO9yVz3wpCWYmE6Ux+lIltRYAh54rv57SgEWUdJSzsfQga
	vVnoQXSKbrl/lMF52OU4q9IfzjsGfHWV71SmRjhIRMjD/AK8wuzGsGIA86XXWb7O
	VCvhvLhh7+33uDHrX5ztuAjIOtYCWrHr5PR5iBFxVjr+4aOAMnnalWQJ4jowzoLy
	A35yWiB3+aR3R9xiE2aGXaBwNp7mnClyw==
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g0a3p0aey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:38:26 -0700 (PDT)
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-39fb3a7fed6so6705841fa.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786657105; cv=none;
        d=google.com; s=arc-20260327;
        b=RDUkkE9qV71xG9DnE1MnNdTFP8r8ZLvubZiOpmO4Oi+HvgHcrT/hMaWzMjyzJ3abtt
         GQvJAvfz3n25wWYCzGA491RRlV0o37fri56SRIMVwsBhBy7Ydljbh6UsQ0bFtWhrLGdL
         N7q4ZxN2iuGSbBT2ge5RLzOwtcylwMAeF0sa9gaDsJa2ioDaF7vx0SvijcgDIz0agW8x
         sQssh38UVBOQAksnSa2uhiNAxR7PwLCRErHGqoQ23C0Ixb8KcWZPASWpauGDF6c3mrdR
         Fao+bUFB68RUK+OrdXQ6b7qcOXNC+lX1Arhqf7m4S0vltIsq67gMCCNxli/CPeSatP0f
         ds1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=VlrbFOJxXjmsZIn+Tcg7ufa9fCfKXuFTRewOfqyQ8t4=;
        fh=k336HQotrnb8u3jG04Td6bq5IYFgudF12exdaVzSn/0=;
        b=b0m7rQ+QTDFKxZt8RmvvYKQefcwIyTK24qkYzDKpNZ2reGXlslox12WnVRro0QUOgE
         /ThdRFxJoSusPmwcbH1AoEGSqDOdzwWWDc1s+PKubzTXU/0F/+eHA1Y8NdBqW32a2o9s
         6keBnco1ECJ+ZabL8iLRWfOILQ9Lnsl0Xviu8DOsz6rGXLtLNzI3Cq0gJN6qvWrvcNFc
         bV8FtkHsxm1Uy75MpAIJEXvXdTNx2GU4VI+gKkMV7nFvMNRDFeysCLrCzpE4meFhGUi/
         6PsuhfBg0pLGSc+635Mp0Wv8orI94nvUH/6VCGv6mL3n7Jcu/pv+E7uiLYYfdfqR5gKO
         OsKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786657105; x=1787261905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VlrbFOJxXjmsZIn+Tcg7ufa9fCfKXuFTRewOfqyQ8t4=;
        b=QaTqvoC1lMiXBiYoYkPictCHVaJouR7mpVaBe9xMJaOM8Em/cCyrQVFnIYVJ1c1v6a
         bskJACWRduslGPRQwQBZObfWt2JC0ReTjypHrC6YD2FklY1hlMNZuUgLFHn0ZyGpGhiZ
         ICNBHp+ajHf2eiCVL1kbdUU3GGVp+Bjykr84rPpiNwd0UbMUhC0Eb8pKva7oMIEkqkD1
         KTeblkvBiu4O+1T1LxuoKZMRVsVtu6h8B+n1HammbQQDLwws5dr3CUgpcTbgKn/ImWkf
         9QuaVe09Dar6JGp27nNWGmA7gFNoG1uc2ncTy9B6u2JI5IaE8oOojPZtmjaIsh/TVb6V
         OXQA==
X-Gm-Message-State: AOJu0YymkkFcRdlpEmTeTJB4qA8WQNTeFXLwuu2rS7JC8avDNDrsE3eb
	Fn3sK9C4XAmGG+mXKtz5sFk81a3fHUD5tjEi1IBgh0ngfhOhKNfHK1KbBIC5kxxDbhhm7aDlJR3
	vgEtBUTkgtSuZVspioBSwJDQ3POUyEfRlVx7Whwv+TGAWcKgleOHe8a8qpbiMZbKGhATp2IRCtG
	U53pNJkp3szHdpL8bryt1T/Z+IhVc=
X-Gm-Gg: AR+sD11B27SIUB6q0gBWrb4xOcBXkGvTHXeFMKpwGODHN23HoXI2girHCTf/Pwroo46
	KG1QqjziINOaDo8Ls0CYmbcNtsTKK2qm9YkbVyKlEmgrytRxg5TdubStt60rafJUNp5/qV/+lPm
	+fCCFxj6j866s74NPBAoB4O2TZyCz+X9sjdw9xStalE83xhD/rw+ctnyVlbiZLL76ZCmEr+NN8
X-Received: by 2002:a05:651c:1501:b0:39e:bcf4:419a with SMTP id 38308e7fff4ca-3a11b965fc2mr12557551fa.5.1786657104735;
        Thu, 13 Aug 2026 14:38:24 -0700 (PDT)
X-Received: by 2002:a05:651c:1501:b0:39e:bcf4:419a with SMTP id
 38308e7fff4ca-3a11b965fc2mr12557521fa.5.1786657104344; Thu, 13 Aug 2026
 14:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813213558.3103179-1-andrii@kernel.org>
In-Reply-To: <20260813213558.3103179-1-andrii@kernel.org>
From: Song Liu <songliubraving@meta.com>
Date: Thu, 13 Aug 2026 14:38:13 -0700
X-Gm-Features: AUfX_myaXLXF7I1e1-nwnAp5mBzZDyLMTyOJCZbJqOTPm9GhtjCjY642z4U5XNo
Message-ID: <CAAeYb7=dJ5XzNJWdSUr33z2XKF2SgEyGACFC0+LDy9PkD2LZLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Use ping_command() for IPv6 pings
 in lwt_ip_encap
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDE1NyBTYWx0ZWRfX5pSDF8q0/EMw
 khbwLzL/WM2PD9EOSh7DjhXZqc5yX0NRZd8RQ9CXQKKSqX7IffkS8vAvrnHqkjKcdqIKYW3DyNO
 Amas1duWH+U3fQZZtp57XAl9cXPUj9A=
X-Authority-Analysis: v=2.4 cv=SPJykuvH c=1 sm=1 tr=0 ts=6a7e3952 cx=c_pps
 a=SnYHy3I4CegsE2y0OFdo8g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=Q6Sk7xOH9uQNSF0G_qUA:9 a=QEXdDO2ut3YA:10
 a=bxEOM3YTG7yY-q-zGZQo:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: mAkHbL0wPrNuym32ZSHs5QVbV_OAy3w1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDE1NyBTYWx0ZWRfXwb3ZzgnELf5I
 Gj/uyVg6QWRn2v0E2rxbbnsRI5Dk/mw02l/zJpTWSEN3vtzPGy8v12PzFPv1XhMDgtV+xSMr5zK
 CA6FFale8LkijYl5wJek2ERUQAH2lQye4QgbHEjlx5RA8w4iQORHatLjUrGUzGhHKxha0HoTNSo
 k1ubvc9Ivs8QHKIz2efJmtwiz317GlWpM54No0HFRjVpWq7qSoND95Fd/7+0qP12mSxdFMXsRoV
 24xb+03Mo+yYS2hONDx4CJPgJQw7KwDZ4eIowvlCnlplhUCDEJhgq5jFZg1dY8mwSgAfP7LEyZT
 FNa9F+8rGoLJQczwgDmY5+At855wpMvVMKa/ha1EUwJ1coqZz81QCNMWm15lBDiPMRVdAxOWvO4
 YK1uCUH0/DXF8rKe7PI7CKWZ4+ta2cJhvoGUMo/yKJ3eKMJxa/HQgHWuN58JgqMmExP1O6Toohq
 k23WrbSMBtoWLvCo10Q==
X-Proofpoint-GUID: mAkHbL0wPrNuym32ZSHs5QVbV_OAy3w1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_07,2026-08-12_01,2025-10-01_01

On Thu, Aug 13, 2026 at 2:36=E2=80=AFPM 'Andrii Nakryiko' via Kernel Team
<kernel-team@meta.com> wrote:
>
> lwt_ip_encap hardcodes the ping6 binary for its IPv6 pings. iputils
> merged ping6 into ping long ago and distros have started dropping the
> compat symlink -- Arch's iputils 20250605 ships only arping, clockdiff,
> ping and tracepath. There, every lwt_ip_encap subtest fails:
>
>   check_ping_ok:FAIL:ip netns exec ns-lwt-ip-encap-1-0101330 ping6 -c 1 \
>     -W1 -I veth1 fb04::1 > /dev/null unexpected error: 256 (errno 2)
>   #217/1   lwt_ip_encap_ipv4/egress:FAIL
>
> The IPv4 subtests fail too, because check_ping_ok() pings both families.
> SYS() runs the command through system(), so a missing binary is
> indistinguishable from an unreachable peer.
>
> network_helpers.c has had ping_command() for exactly this since commit
> 372642ea83ff ("selftests/bpf: Move netcnt test under test_progs"): it
> falls back to "ping -6" when ping6 is not present. lwt_ip_encap.c is the
> last hardcoded ping6 user. Fix that.
>
> Fixes: f5e288943e2c ("selftests/bpf: Move test_lwt_ip_encap to test_progs=
")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <song@kernel.org>
