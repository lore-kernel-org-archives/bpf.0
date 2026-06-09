Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C135E925
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 03:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780977043; cv=none; b=M+KDUjPW1fXw36Hvq9I0z1779Vh2CgnCkImNm7aiS75iCtDPjIXNlZd4QnTKBxszk7R6CUkjB3q2XPO2FsDdJiYgXKlzDhdwGljeM1pFaaDsuodORsniJ/+XDo+aWSnALVbT1UIxxKsAbdOqCKYOkSl4OWxlQOGQxOlj/qRS0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780977043; c=relaxed/simple;
	bh=6MWcPHvGdkD1PSVROEXAI/WwpVMlc5H/ZGCN4mKVQ7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NsPFqFWwrNZR29xnWdpxW5WA8Y7KqBZc6Cgg/fnFzu6VpWxUJhcGlOuE9QB0WF3fE0rhzi9XtBE0akBY+U/eSnhfYHswNmyRBNEpIB33vWyPPyRyNJOzW5dm77l8d6GjrfJ+JxHrPCPTznKrct6eDtHYjuk64as/jmCCIqZmyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S76jQJtD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S76jQJtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9DC1F00893;
	Tue,  9 Jun 2026 03:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780977042;
	bh=ixOhyYZxkJm6oW3F1RkdvuyX6+tqKtEB0JJAJ0N8I1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S76jQJtDc7wyIH1uuS7PpNBvLbp47XmpiL2NxGsr9LY7fla9V5f18jneA3b0rTIvg
	 RiOo2Rf79pQ45NDJo+7y4FXWZHY3Xd931Cok8L+puNUeFGAxs+iy2P++5h4CSEKXdm
	 QSGao7zGI1OBJQ52chBjnNPtGVvAnpriuWZBGxaIEdsbP9ExUy/C9cQCKkt8Jm956n
	 /LTXrjqHT65aAEpoxPim3Q0EoPNBEiumELyuzyTFbpVnVMAP9VBHuvzQtSO9jDVCyf
	 URbcqEqT2PGvA3yXPg+KdJcsyrloLc27e16DokYqutuJ0BNlcKrgqgh4euXzjWyDZu
	 8rqbJmqv7UZPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: correct CONFIG_PPC64 macro name in
 comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ethan Nelson-Moore" <enelsonmoore@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609034754.26081-1-enelsonmoore@gmail.com>
References: <20260609034754.26081-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 03:50:41 +0000
Message-Id: <20260609035042.0D9DC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message incorrectly references a `.cc` file extension in=
stead of `.c`.
--

commit 0470ac8961767f5872635d802105fd894e99c3ae
Author: Ethan Nelson-Moore <enelsonmoore@gmail.com>

selftests/bpf: correct CONFIG_PPC64 macro name in comment

This commit fixes a typo in a comment within the BPF test program
test_fill_link_info.c, correcting the CONFIG_PPC6 macro name to CONFIG_PPC6=
4.

>     A comment in tools/testing/selftests/bpf/progs/test_fill_link_info.cc

[Severity: Low]
This isn't a bug, but there is a typo in the commit message. The file name
is referenced as test_fill_link_info.cc, but the actual modified file is
test_fill_link_info.c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609034754.2608=
1-1-enelsonmoore@gmail.com?part=3D1
