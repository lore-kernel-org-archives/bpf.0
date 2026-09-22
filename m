Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688E33DEC2;
	Tue, 22 Sep 2026 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105594; cv=none; b=ek4+QtciS+mf3d9wLiRrGdUTdyCCBmmWjqoWcdu0cx0DF56CCJS41z/Gu5RvqDt6Ct3kciYGg8V5t575HosQ+ctC8TSs6LyCgqCqyXqLGmGnbUx0UC7osU91JgM/TRBPmFOxLVxxbpNBaBc6oyPutKhaxk8CzAD7aHGBAZ3j0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105594; c=relaxed/simple;
	bh=iiJJQfBkLFyxIlvKugCAcfYophjpKylV/4Fx+zHD+cU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I09WieNNS8kSKAqSnin9fepIgnG84A4raIhpx6AG1nbLPwO44VaZtHzc1N1VOgU5L6QMu53EXXk/u/UasrQK0AEY2dlWSQTKNtCwDzjZIpcaE4pZuMP7FfiuYBVTgrEsJKgd45CUcLzTelj5WEtulJ78NDr5eCr3GXMZAx1EGNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8638J1m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8638J1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC881F000FF;
	Tue, 22 Sep 2026 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105593;
	bh=iiJJQfBkLFyxIlvKugCAcfYophjpKylV/4Fx+zHD+cU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L8638J1mWaOM0Z+2w9jxm/wrRcYGi5bogdvO+SZaG5GLjqCB7/K6fwkGfpe1xwaLQ
	 FcpU7SIxNBwa4klmdQwCaqNHkLm2WJwAgbGdr960db0H4Yr1zs8fcfXjLYSjko65D9
	 Y5jjGeoypZ/jwaKAaPRAkEF+V5L2kk7ox2DX3+sxXv+frfVRAoGxsCdPUEHf5URZbZ
	 3rdFRjIWdWHwgvPjTCOvvpKLJ1x0I/NkLIIYBIA934Qz1+xLAFpQucNArnT78+aOTF
	 qz8gj2wYc+F6BFN+UpgAukwbd/zuRKJ/yY02SnJ97tAh4HVFYIDqUH/1eZOG4zXvKO
	 Yy7T4YOSMZREA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/14] parisc: mask compat syscall arguments in
 syscall_get_arguments()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: bpf@vger.kernel.org, audit@vger.kernel.org
In-Reply-To: <65f32a82d590b11984723fa6f26ff96175679f9a.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <65f32a82d590b11984723fa6f26ff96175679f9a.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:33:12 +0000
Message-Id: <20260922193312.EBC881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> A 32-bit compat task may leave garbage in the upper 32 bits of the
> argument registers. Mask it off in syscall_get_arguments() so that
> in-kernel consumers such as seccomp and audit observe the same values
> the syscall actually used.
>=20
> This previously happened for audit in the parisc do_syscall_trace_enter()
> compat path; do it in the helper so all callers benefit and to prepare
> for passing pt_regs to audit_syscall_entry().
>=20
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790088067.gi=
t.rrobaina@redhat.com?part=3D8

