Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6402E38A702
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170292; cv=pass; b=iAVlHGbOeA19k9W2mfEae0X86UFalqELixf9kgj36TZRgARAAi5+BhpyLbBOeDdZC7KXEofBJeTw6MfaZr4lF+dsjkASXuGD0Yoyt1sa/rLJEuY+YWDFJwa8uddlZ8peRPOvMYClq8ZwaHd7y/SKfY5fSFJKOootYC7yQDGa/Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170292; c=relaxed/simple;
	bh=oFjEqSzBz9jxLzi0FyV9fE6guEXHs9dQF4DmqXHdfzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUGYBskSQJyBrlxoalQw581sULJhFTH/movmCe0j/BiTaTVHwIp3EQshoBPmzTLrT4ZHEcDGYfw6LEB/6C5pDnSFEH51reP0dyuqzqow8tpfKrnxZYyimljMsZdbs5OAfZV1kbkfON1luoZZoEdlMBDkBhL5Q/0N/Zzcagja1xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8rFwxAn; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8rFwxAn"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so88728a91.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789170288; cv=none;
        d=google.com; s=arc-20260327;
        b=f+iu5C56Mv2hCNK3gGSuVV91Fui0wJrb+s4BUHf1H5lJO9p/ciZyKBpXObf+dV8cU0
         TUeFLEN+3+IVSOaBY6oz55mTTQusKzRPmViqLPc7Jck/fd9qCCt1Ac1hXyHOFbQnksvV
         KzhRDuasrYYejUj1DYcBdz6KupdeC+m4f5yizrC0iR5LYQIfC1WIzLhM3+YHJ3viyh6u
         3g9vl/jPYPWYMSMasplbOlMdllUSUsI3w0QgNOAZhhKp/XsnDFC+eEpo6UYXZW813GmO
         +1ips1mgv6W6IY+W6mvhpH8BAaNZjCNK2vNOyTHJNwG8FL02tzruCYDi4u775LaCDqR2
         HBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AfvJqI7EztOD8K6lsZ5ZhOwJ4pocupP3cr9De3Lt8JA=;
        fh=Pt6sKbZv0ijAhavqZflLqF3fSjEVzNxt6H6Xlv9tcSU=;
        b=X9rSKAe70E1oL+d975D8kK9qzE6DgWeSvGMzme2RI1utvNAsvjLOwLx43HUe9sxupZ
         I6bL1+1UflnxDzRw7iY3mIi2DI3WTKkxpXRG0nLjmD+MHGF7ifUUCsiLS3oqLa3jrxMp
         DeOW9cRMEHwGRpkEvxDqLOsNWajpTyXsyw7i6sPBwMP/CqeaOqm7raDk9RtPHiPytmiC
         /qvRzyFhLQmMZycw0R0cKx4M3tYZPMSlZGHfQeY/2R69DWAo7LYyGaqcxr4kivm6d7IO
         znA+pZcAOQSxKL7izWtXeSZwAKQR7K11qxpnXgBqdRxfMlZWFFWl2le8b4r3PnIEaYzk
         iVuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789170288; x=1789775088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AfvJqI7EztOD8K6lsZ5ZhOwJ4pocupP3cr9De3Lt8JA=;
        b=T8rFwxAnyELg/Y+JobmWcj9WrvWkOTrOZWn4J8NtT8zONdGPcYOrOjQuzwJ8KNIfQ4
         TV2bDcKIP4Aqh4tZiBIi/d2fxLLz21wkVYG9HhwUzr3poMYcs3M9hhGXIHzNFHDxHuaC
         lCBHmSwijbZ8f0DxdTXYPH3FYAgfw4SjJhb9zS9exmV+XwaBjUy8OERhVMa/59uT2dfe
         dOGOr2GcX3N7uh+bjpKX0F4SPJTLxc8HZ+FC0p53+I2m2VSJvLBCkKfEFU9+kJQrg97/
         12JVF7tjAf44JHi53xKiN7WcJ0280vG0TwvHZhwr00SZbqBHrnSnE76mAx6d5zA/rQkj
         9BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789170288; x=1789775088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AfvJqI7EztOD8K6lsZ5ZhOwJ4pocupP3cr9De3Lt8JA=;
        b=eHTuyualAQf9XNvcAaSKp/i9bAKlnTZkmj+xzuxnffO0C/jUFdOr3WYxqZGYKyTyVy
         bfwXcCs6maWJtxo6hPjUu58XlDglyiRSqBLr/eSq3Vvd/91PqkIHnikWjbdZj8A2kqRW
         VuGvXQJSKQEc2wGzMsc+PFEQQXSrothFDyh4f3GIJ7gg+keUkYpYVBXRv4jxKFNtUSPb
         UupcuNBIQ33x0Dm0GgyoDx0QaDXy8rFkUNaiTHVX1aMDrVIYzb20amQ1Og2MvhvSwcE6
         t+d53PGDUoNLnQyyDxPRpi2Wo7+OM+WttXv7oDw4kUJNJBEh7ANF4leNoG8Mj6lqiWb0
         K//Q==
X-Gm-Message-State: AFuF++m97LdF1906O03ErFY5OA6iBAPFXkywhOpndOUwj31GQksp0A/m
	/LgfZOYgDJKOfB8bEK/ZiM3G7JaEb9fCbqINu2VzvJh+guRX/tlmdsEdpf/1GymQfkGxc+iQMjk
	G6RcmmW6y+VcynLMQx36nSHmBycjYXUg=
X-Gm-Gg: AYBFou1i8L7QD4Gnq6Q1D5hKQCOB9dQRHutafYnxDxnGd2Zcb9tm/uQCWMn/+cyCQhf
	LUgbapm0lQHCsOKD0G3FGE7h1bnMjfQoCz5vgKhu6siZkaFQMkLv/5IOVUsc12HIGRi2TS84C9l
	mxpnaMjmcThAlb8P68zyNrmR+bV7+3RO96t70/rYwGFnCOCOhU5uE4SxzKWT5X8odUvh/m+gTj5
	s8U4NFumiVpQ/Y2PO7SzjmW20W3491ofL1axtfN95sjSMiYOhvzsBnG/5AjBk/W4UWZuYQYoCao
	Lz0wJZMyXqikpHrnXXB+k40LlOhyjGAZw9Vz+NdvhvBnrNk8v39lVUj5yUI+ffzLjQEf7rVWdnR
	HYGlyEH9Ky/NqTvqyhnbN6v5rZbf/mcKYmZGBMA==
X-Received: by 2002:a17:90b:57c6:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-39dbbeb57a5mr851966a91.7.1789170288221; Fri, 11 Sep 2026
 16:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com> <20260826181825.1826541-6-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260826181825.1826541-6-andrey.grodzovsky@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 16:44:36 -0700
X-Gm-Features: AcwNN1XjZLAMmFLMDDeYS8Zg9eWtP57A4HuS5iyCRr1ddSUCsVjU3bZsreQ2T4I
Message-ID: <CAEf4BzaaNbEZnV=wADR1T-AQJapgXhJzGeaoHOMu3mj4=PNANw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Cover BPF program dynamic loading
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com, 
	slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> From: Slava Imameev <slava.imameev@crowdstrike.com>
>
> Add load_type and dynamicload tests: the per-program load type enum
> (disabled/auto/dynamic) and its transitions, set_autoload() bool/enum
> compatibility and autoattach restore on exit from dynamic load, the
> full dynamic load/attach/reattach/unload lifecycle, and the
> loadtype:dynamic BTF decl_tag as a declarative alternative to an
> imperative set_load_type() call.
>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  .../selftests/bpf/prog_tests/dynamicload.c    | 222 ++++++++++++++++++
>  .../selftests/bpf/prog_tests/load_type.c      | 167 +++++++++++++
>  .../selftests/bpf/progs/test_dynamicload.c    |  40 ++++
>  .../selftests/bpf/progs/test_load_type.c      |  31 +++
>  4 files changed, 460 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c
>

I could barely find that __load_dynamic tag, seems a bit subtle. Maybe
we should just go with SEC() prefix like with SEC("?..."). E.g.,
SEC("!...") to mark manual loading. Seems to kind of fit, exclamation
mark calls for attention, no? WDYT?


> diff --git a/tools/testing/selftests/bpf/prog_tests/dynamicload.c b/tools=
/testing/selftests/bpf/prog_tests/dynamicload.c
> new file mode 100644
> index 000000000000..799c43034ff9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <time.h>
> +#include "test_dynamicload.skel.h"
> +
> +/* prog4 is tagged __load_dynamic in the source instead of being set
> + * imperatively; verify that an explicit bpf_program__set_load_type() ca=
ll
> + * before load overrides the tag's declarative default.
> + */

[...]
