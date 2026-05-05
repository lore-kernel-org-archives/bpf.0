Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70649366806
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005364; cv=none; b=u6fGLhKTBCmFzz5xoSHWKYeeH6QODCqL0eLdOh9iC0kMit5RkOWoqCkG2m4zKxDnZOog3Wjl04bc7CPZunFAspGcWgeX6FSkmMYbNCXppj0MJojLznrXTUM9GzoCV6RDSmzfE2wTEiSdJrC++yK/GTdSxJMQMyXNBZS6k8XaiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005364; c=relaxed/simple;
	bh=tzb2zx0uWs235sjA8qQuPagb/DlG2ZeDX5zwSV89pC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WxpUdTJC9OCOGjnXx8r1rS9G0TWeLeMhoZ/WlK53AIs2Sceu5dZ+uKcQPAnwdZKBAKorznv+Vopk8kqebj578tEdMTK0A6QEAgcmJVi0htFE1ngYC/A54Ue/EdfPSLNsDSS5oMUjIN0T+HqjFLcbBjk7Xo3bwQvrFGP4Vmg3I4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImZIny3V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImZIny3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A151C2BCB4;
	Tue,  5 May 2026 18:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005364;
	bh=tzb2zx0uWs235sjA8qQuPagb/DlG2ZeDX5zwSV89pC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ImZIny3VbSvDMXTunVNIKG8xo9StQA+AJMl0TxIgWvO59L897rJZiZb/a9MABysmL
	 JZza6BaGFUqMa+K6Tfm/LIxwNnCyFUracjIDe/ayfdSbmZLpFj8aLhSEJhqKZTsafR
	 KFOq+lHWZ5RbGQPOgqDY4QGpILQrVG8wnejJ0roWpjTCu++0PsCwYJs/Gtp6GGv2n7
	 iKXFqk18TWpc6FwKvyea/RU0Qhzit3YMTsq3JfOUuMNLJaY/r/pSMlro1YqOWsuUzA
	 BX+UU6ECavlFw3XuHOW6QcVVUdNJG4/l8grS8VxxYX6VV24/DIXMXw8EzK2sUL0z3l
	 +PVGeZ372aV1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/19] x86/uaccess: Add unsafe_copy_from_user()
 implementation
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-5-jremus@linux.ibm.com>
References: <20260505121718.3572346-5-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:22:43 +0000
Message-Id: <20260505182244.0A151C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Variable shadowing hazard in unsafe_copy_to_user and unsafe_copy_f=
rom_user macros.
- [Low] Missing const qualifier on the source pointer in unsafe_copy_from_u=
ser.
--

Note: The format of this report is altered due to recitation restrictions.
The original patch code is not quoted directly, and a free-form summary
of the review findings is provided instead.

commit b652061f302d029392e67f46699e5a2db0abfaca
Author: Josh Poimboeuf <jpoimboe@kernel.org>

x86/uaccess: Add unsafe_copy_from_user() implementation

This commit introduces the unsafe_copy_from_user() macro for x86 architectu=
res.
It also refactors the existing unsafe_copy_to_user() macro to use updated
internal variable names.

Regarding the variable naming in the updated unsafe_copy_to_user() and the
new unsafe_copy_from_user() macros, is there a risk of variable shadowing?

The macros declare local variables with very common names, specifically __d=
st,
__src, and __len. If a caller passes an argument that happens to share one =
of
these names, the local variable declaration will shadow the caller's argume=
nt.
For instance, if a caller passes __len, the initialization size_t __len =3D
(_len); will evaluate the right-hand side as the newly declared uninitializ=
ed
local variable itself. Could this lead to the loop copying a random length =
of
memory based on stack garbage instead of the intended length? The previous
implementation seemed to avoid this by using uniquely prefixed names like
__ucu_len.

Additionally, looking at the unsafe_copy_from_user() macro, the user-space
source pointer is initialized as a void pointer without a const qualifier.

Since memory read operations typically expect the source buffer to be
read-only, callers might pass a const void pointer. Does this implicit
dropping of the const qualifier trigger a discarded-qualifiers compiler
warning? Could the source pointer be declared as a const void pointer
to prevent potential build failures when warnings are treated as errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D4
