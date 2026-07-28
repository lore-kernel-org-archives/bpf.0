Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056452E8DEC
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203815; cv=none; b=WwN7i6nwowWjeVWOfM2GISjSlMpy6FsszGRoYfCoZMfN8zqAbedpxm0qG8UPcvmb6ZMQI6Nn9EdRJSmEsHmxrnCu197R5TycBZ7DOWw3vR+0JDet20y/3xyX2o5BEeFy51VoLrt6C9kfyXfB/BeWicSt5s4yvswK/VEyY/skHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203815; c=relaxed/simple;
	bh=m+aN3BIXIQGcugLGLM8L51CEsux8ysi6MJp5f459tQk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rr5PRmewTPs+JWSGgNUPt01yhgvDk7nTBCPJ0q8DpxKuFPCq0StBRNeTxGz3g6sz8lB9HjljQAkKguJenj6qxXoPf6wm4rCR8VCMZqWfq9j7WLx0MymZSnXFQLCpNUJV5dzTrXrtSv5nLcPvNa6hN3i5YPGCsESp6KhtiQRhQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Bfcp5dDo; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Bfcp5dDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785203803; x=1785463003;
	bh=VL/yldyHfR/AHOb8W8/Zoa8lS2k/O4zzdr+uFJ40S84=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Bfcp5dDoBmqtb50pJc/3m5asj1PRwY1PyetDQr1H2M6SSuSYwwgkUCwvh2uBZZOAE
	 HiXbd4EWkzfJmAgEK2T1/8ZwKsTR2JyQJmF3Dvil7gtKXdZZygPpIYizlWV7xe6gcC
	 SRR/KFCX9lXbrE8yQM6NHIqzfszWeRIVjjehi/kxogmG/T6NpebyttFVnz8oJqmgZA
	 3uQfuhLsBCjoGyJMG7KQ3CG/T2RgqgNO9B7F4/uYzQLybQetYDz6WhlrrzN5owtsTU
	 qQ7xNHGQR0VoCx+reJ8o6SJd3I/gS8Lv5hL0Vsa9jjWRfded8w568BWF5zyBNi7YYk
	 AGsB34IO3lETA==
Date: Tue, 28 Jul 2026 01:56:38 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, Vinicius Sampaio <vldsampaio@pm.me>
Subject: [PATCH bpf-next 0/2] Simplify min()/max(), contains() and fix normalize() cnum implementation
Message-ID: <20260728015601.1567098-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 9109f2e6f0e850f7be0d7485aafdf1fb1f6caed6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patches simplifies some functions of the cnum implementation:

- smin()/smax()
- contains()
- normalize()

Vinicius Sampaio (2):
  bpf: Simplify cnum contains() and normalize() implementation
  bpf: Avoid redundant min()/max() in cnum signed bounds

 kernel/bpf/cnum_defs.h | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

--=20
2.54.0


