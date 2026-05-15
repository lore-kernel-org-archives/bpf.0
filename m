Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEC83D646D
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836568; cv=none; b=kx5qUuYENl/6NSjxvVL9gmQ92SHtev2WgPVINSKC35IRli49gGFD7rtRzflAXk74r9P+Y14s2HeQp/sLjY7fdjJ5OcOq6M1jAl2RzJ6nX8omKm6NE/50SwzVVDZMzTWJ+BeF11J7oRX7ZFcNU/TQMTRejXYHgyYaP+dV7JeDFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836568; c=relaxed/simple;
	bh=DAg+2yyVGRMQuMHPVzep/jV2bZh23VNf8ahiaalqIK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ncaDJPUQr3ncGrZ22Zn1tP2NnSBvSVv4DP/GJ0fGdOtMj9rCy/L98ItHiIrQmF/fT5UGKh/dEQ/lj7d+kYXbfdYEFTzh5YRWfAROI9BjwuhTkYyO5Yb9EAe1FBBs5V4yzVsmpiklZ/ba6GYulkrFgVq6TzZFoOp+7nd0MoYXrRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpSyW9Uc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpSyW9Uc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED08CC2BCB8;
	Fri, 15 May 2026 09:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778836568;
	bh=DAg+2yyVGRMQuMHPVzep/jV2bZh23VNf8ahiaalqIK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jpSyW9Ucw68ivOYR3NsJc/O1on38l5RgXo5xn/cLAbpqR8u5ZhrJiv/6h/e9WtM5b
	 gnbJan9TRD6wvRjCbWMwt27FE2hFW8oIk1n7jsvHhU1+CfK86s3y/JVoTL9ieVKsqR
	 bvydl3arNPSxpWJBzCS1O5Xv8WBnKZIMrkbR4Ri/it5zFekBWnwcPstfjBYMoyG3Ln
	 YzAasZWsa5Bzc7D40TVgUCNbgKhW75VX56azapu0lrPQXFX7/p7GHc4Anv2egFZu9+
	 N4FsSZt/kjGtGdiN2/5F3TKkEl92HUSZOBoJMwJzy5XxN8WKN8VuJJxZaxmFPmH/2l
	 gl0jw3H4S0d/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: make bpf_session_cookie() reference optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515090631.284426-1-arnd@kernel.org>
References: <20260515090631.284426-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 09:16:07 +0000
Message-Id: <20260515091607.ED08CC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit title incorrectly states 'bpf: make bpf_session_cookie()=
 reference optional', while the patch actually makes the `bpf_session_is_re=
turn()` reference optional.
--

commit 955fac0158a2cad097b15c2d40f2d73bdbbf8828
Author: Arnd Bergmann <arnd@arndb.de>

bpf: make bpf_session_cookie() reference optional

This commit fixes a build warning caused by an unresolved btfid symbol
when building without CONFIG_BPF_EVENTS. It wraps the function reference in
the appropriate preprocessor conditionals to match the verifier's behavior
for other conditionally built functions.

> bpf: make bpf_session_cookie() reference optional

This isn't a bug, but the commit subject mentions bpf_session_cookie(),
while the patch and the commit message body actually update the reference
for bpf_session_is_return(). Should the subject be updated to match the
function being modified?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515090631.2844=
26-1-arnd@kernel.org?part=3D1
