Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C8312834
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177501; cv=none; b=YGf5gAo4ihsDUk5f8312wqxzfph2SKmOcOVbP6qn7LzF0vHTVJihBZ/HWl1/Mau3etS92b+BVFz8Z5iNxxrSwSHvB6kjXJdJKLb8NXFWOf9SgSc4A9j3z4pnSNdUb9akoKlse8MZ6UUhqxsOGI5nXtc1f+bVo08vyePtHbAIX/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177501; c=relaxed/simple;
	bh=+KHyVErE36yQldK3pNGnzzd6j5U2wbEFdIJlFT9zrvo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Usq6HSsV0u7qi7Af8TXaITB/Y0gd1y5U7JRs7zDVtNZKOj4+qGHRP8hSFaPpmlmwKvxTWCZ8fn163YIF3FKyoUu7mnt85udLkngDDmEXAS2Yb38QcM2lk5LpGczPhwh+U8zh5tkBHl98OuQl6BKR+mvX/DcyRrl6I6t4FMGSdiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xeAnws6m; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xeAnws6m"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8DEB51A199B
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:31:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 636355FE46;
	Fri, 27 Feb 2026 07:31:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD2E61036912A;
	Fri, 27 Feb 2026 08:31:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772177495; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+KHyVErE36yQldK3pNGnzzd6j5U2wbEFdIJlFT9zrvo=;
	b=xeAnws6m25UlZmPDzxbaHn2Ko5jrvRlkBO8syh1tQtdBwzASjXVJxRUUAnCUPcxUHz/+BT
	sZzTCJQ480PSotv7/3ux1K3JTD35Ly+5SJX/r7l/XveLFPxZIuDRY2XIoYTK788QKsoNTK
	mJ/gqV+v2RivjhDo2f+RgMmFgaAtB7AShfL6rX3DR2zZN70jgvfgSwCnOb/JBzBwdVwpoG
	G+hSvXj72agBp2zn+fzdfIYMykdqnPz/c6VakXg+++SmIGGbxMAYzGuIrJydnMVI7vOc+0
	U/ZYYnYdzxm1d5ARDDqtI64wLfBaZrF2EH7q3GxaY0vd0MlVI2gNn2IKUXadtA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 08:31:34 +0100
Message-Id: <DGPKHPMDRQXL.3ARKDNHT1FB4O@bootlin.com>
Subject: Re: [Question] json parsing and bpf selftests dependencies
Cc: "bpf" <bpf@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, "Quentin Monnet" <qmo@kernel.org>,
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <DGOTPHTTR5ZE.Q7ALRR86ZZ6N@bootlin.com>
 <CAADnVQKM3zCvUv_ja+QCCO20eHZ0qrYpReNguXToZpaf46vEFg@mail.gmail.com>
In-Reply-To: <CAADnVQKM3zCvUv_ja+QCCO20eHZ0qrYpReNguXToZpaf46vEFg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Feb 26, 2026 at 6:21 PM CET, Alexei Starovoitov wrote:
> On Thu, Feb 26, 2026 at 2:36=E2=80=AFAM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:
>>
>> Hello,
>> I am pursuing my quest to convert standalone bpf tests (from
>> tools/testing/selftests/bpf) into the test_progs framework so they can
>> be executed automatically by the CI tooling.
>>
>> I would like to continue on the bpftool tests, especially
>> test_bpftool.py ([1]).
>
> I think it outlived itself long ago.
> Just delete it.
> Any new bpftool features can be tested through test_progs.
> No need to test json output specifically.
> It's diminishing returns.

Ok. That's a doubt I had while converting the first round of tests
(bpf_metadata, bpftool_map_access), whether we really want to test exact
bpftool CLI output, or if test_progs->libbpf testing was fine.

I'll remote this test_bpftool.py then, thanks for the feedback.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

