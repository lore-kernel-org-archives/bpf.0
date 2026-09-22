Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CCB33DEC2;
	Tue, 22 Sep 2026 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105605; cv=none; b=eB96ZTfd2mhJFeSURz0uZFEICVsg5rMqZ3kkR/08SR2zwb9+BuUMEpsBO3jqJaTfYoCxy4gGOR3I1Y16C+Jhrz6cY0lgo209gM0AJvR+zCugyC54cM6C5qSxdK59plVNG5sheDB20w+jfZ42sXxvbqOcLwrKh/DuKHarpenBgVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105605; c=relaxed/simple;
	bh=PRoocq1O4fAGktz+8rCUaT+Bpf5yzp0H9WYzBEZ72jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q+Oh0+Q2omQQKJj6x81BDeaKBWXZcaEL8yqrlgeAzpcJkc0ABQTKIN+GB3whcOX+dVY2rdInfj/IsYBbbh67bJHDNDq7jyONfqhN/1Xu795Ome2N75+OjHVEb8a7iC/PPlD1tH6OKKEqL9XuNIswAAFBDuGaHVkbhe35wNzdbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHy/aO/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHy/aO/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F60F1F000FF;
	Tue, 22 Sep 2026 19:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105603;
	bh=PRoocq1O4fAGktz+8rCUaT+Bpf5yzp0H9WYzBEZ72jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHy/aO/ZsqXNj51iHp3vwGMraYfLcc5VktZhDSWDEryLe/LJXjQKu9B+bW0QX0YVb
	 th/vRD0LrqhomizImqHR8qH7mGvOFsVOtst9OU+pVMszPY9ZeZUFHDKXviSt4nKhGr
	 P8fuZrnJMKQco5hZ826FuhGoXsluD+JL6tpmfvhMUTWFF3532DzmOImmabMG80dzkC
	 uTehftnaF984N2QBISfvEcJhURXwQaEt837gZaGTykJWWwVHcF3AOWP4muA1EG7Qmb
	 dTCNhrqgXKH0Uz8/6PCxS7l0tDizEWWCaPKyGAXjzLKwoME3Uiyjgtg7jEmqO6B6Yq
	 1Rm1Pc7NIYpbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/14] openrisc: pass pt_regs to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <db72a3d5414b6b5f187c51710981296974ffcca6.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <db72a3d5414b6b5f187c51710981296974ffcca6.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:33:23 +0000
Message-Id: <20260922193323.9F60F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
>=20
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790088067.gi=
t.rrobaina@redhat.com?part=3D7

