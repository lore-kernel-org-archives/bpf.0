Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7363B499F31;
	Thu, 13 Aug 2026 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786641313; cv=none; b=cLmai5rzHbuvfrMPVumswjF+twyvVnkE4vgf6yXrJNYnJU2pFWEpP9a75/B7LQwcIU/RnZcUt+hCA0r+4LtrOEtkyYI48Kj6AhvtChjuGl4KmCty8/RHlUBKbo9UJAjNDLe8AgWCZnoLI0xRWTKcdWWP7sidQw9NRYNO7zSDN7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786641313; c=relaxed/simple;
	bh=Nw9vhIT83K2it5bHS+m3hht/ZZnWcdb2Xxzms29KWXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tzcXL16N19aUtVlsL5HaYw6RdNtZB4LqRgdYiIhhZvkAqQBWX2TmY/2P4vQXZMkU10jjrV4gtWmk9Iq/YzL14BO9CmH0qVbXGUiNOHnCsTEZve1Zwyz8RPFbmb1c/g/PAVWCgAo9+GhnIDyZg+82NNdRwZvJYT8ewtFWeaijuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndj56d8q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndj56d8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DB91F000E9;
	Thu, 13 Aug 2026 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786641311;
	bh=Nw9vhIT83K2it5bHS+m3hht/ZZnWcdb2Xxzms29KWXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ndj56d8qK8Jl3HnWJUfuIONVMKOEGApmX6WapnQNwuFNRNeQyOj92tYagEUo+gjsj
	 sZkWS3YdGrNFE24XnTioUfWo7hq1ZGM7696iLVu6CPYSabNutKkQu7XxOO4C1lXzfr
	 Ili1IN55VV/nILo4/lT+o/Qvi0yqSLfLXB+p0zgTTYlvA9/yanO0jlknnLFtrp4Hl2
	 6Fp4RBK3Hr1ZEKi4hCs2kqZKI5IkHqdwUkSKFQLtYfmYlPKrkZoOTSJNuSh2a17e9Y
	 Fp1A4o95RAcifLtGFgiev2cEPlK7IZpGRkShyPZbhAQUj4WhOwvHKAb1O5hkxNF/fv
	 mcUpMzvGIoo9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] microblaze: pass all six syscall args to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <eb3d7ae5d98f6b377a376bdb4dd1b80dfcda8922.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
 <eb3d7ae5d98f6b377a376bdb4dd1b80dfcda8922.1786626275.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:15:10 +0000
Message-Id: <20260813171511.79DB91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> Update the audit_syscall_entry() call to forward the 5th and 6th
> syscall arguments (r9, r10) now that the audit core logs all six.
>=20
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786626275.gi=
t.rrobaina@redhat.com?part=3D6

