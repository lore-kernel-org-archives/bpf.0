Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466162DECCB
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776373443; cv=none; b=OxzezOAC/1bl2x5PxucKQ3NvnwLbJPNUdJO9mUG/ZbZuPZLykKvGwEne2kL2vWWW6rQq2n3HpQyrOK9KpTt+BctPhbZWfNMM5h06qdXHJNRMFl6ceUllp4I0KPhnXveURrKLSctALuLw9pNhfZY4+DLqA8Ddxc/1MNKS7CGAisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776373443; c=relaxed/simple;
	bh=HV7jGFdLhzAZHOmvudPnyfEXv5F47QiRBZi1CMuDfc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyoFxRySuTNJqwvXzpWvBM88EGaWKx7fDI5aPPaM/X/w6xvLRwK1mrxQ9b8QprxcJ8oUMlomaPClY0nl96H9ZeFhwhr1YqzLSADocdrw4IYzkle6HYg2zE77T5siYrB7Y5IlomOvK6ogrhToLv6InC9fs/Ncuez4kKSyTWiwfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8j7GmbR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8j7GmbR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EC8C2BCC4
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 21:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776373442;
	bh=HV7jGFdLhzAZHOmvudPnyfEXv5F47QiRBZi1CMuDfc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H8j7GmbRl+GHnBxw5NfaVONEEdcjG+HchZQ3oWVNjzBUsEjUkPjNePb/nNLqR1Y1L
	 02yujWrHQmWVKd1bUINMZLhlmoEi6QrXTyvuCl58LypRicYs9YJz5OFAcudhxL+udf
	 QIHKEOJHr/IVjG0uD8Qo1ZJnY+JG+n0GGyQbgl1wSi8ok8PqnApGfyUCK/2R8bQKx7
	 HOcXblwLiafH6noobq4GyM5SjQkJ0Ef7D0rjlzFKdJf+ewBwgIn+CThJ+OnRqzzPX2
	 xsroS495txP8s7jXzow9+oqxuivoHFLeR8yetUlMfWJo0i33QyRvWTR0XbjGcIIdS2
	 Qy+sI7lV1HOKg==
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1274204434bso827085c88.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:04:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/hbDb12FD162OePc2bzybxy74PUy0tBLFDLM5PH2tqoUt0+8EBJFiXarh8aMdFT+/+X6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEBB35/b8wucoYrZPrkMkFluofcmgNvfAayJHgpJqkFwCUxhf
	QNwy7yRf32CyizjEWaVOX1/a/MKcrXLYsDDcJBwVUe7sgk/F/Et0cw0x9MOEkZGA7qooPk4dwVb
	M8yEW0KY49qc9/JNR0YHf8sBWO3VInww=
X-Received: by 2002:a05:7022:6990:b0:12c:41ec:8303 with SMTP id
 a92af1059eb24-12c73b042cdmr28854c88.9.1776373442262; Thu, 16 Apr 2026
 14:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416173500.176716-1-bboscaccy@linux.microsoft.com> <20260416173500.176716-11-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260416173500.176716-11-bboscaccy@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 16 Apr 2026 14:03:50 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGbcD940c2OG2RpShEo7WnXj5OPt0qik9x=fEfp3GMVXw@mail.gmail.com>
X-Gm-Features: AQROBzBd3MFbWFa56VUxGXd30U0dprFH8If1gqEB7uKOZwigi_RUa5OVut8j4RQ
Message-ID: <CAKtyLkGbcD940c2OG2RpShEo7WnXj5OPt0qik9x=fEfp3GMVXw@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] ipe: Add BPF program load policy enforcement via
 Hornet integration
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com, 
	Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 10:35=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Add support for the bpf_prog_load_post_integrity LSM hook, enabling IPE
> to make policy decisions about BPF program loading based on integrity
> verdicts provided by the Hornet LSM.
>
> New policy operation:
>   op=3DBPF_PROG_LOAD - Matches BPF program load events
>
> New policy properties:
>   bpf_signature=3DNONE      - No Verdict
>   bpf_signature=3DOK        - Program signature and map hashes verified
>   bpf_signature=3DUNSIGNED  - No signature provided
>   bpf_signature=3DPARTIALSIG - Signature OK but no map hash data
>   bpf_signature=3DUNKNOWNKEY - Cert not trusted
>   bpf_signature=3DUNEXPECTED - An unexpected hash value was encountered
>   bpf_signature=3DFAULT      - System error during verification
>   bpf_signature=3DBADSIG    - Signature or map hash verification failed
>   bpf_keyring=3DBUILTIN     - Program was signed using a builtin keyring
>   bpf_keyring=3DSECONDARY   - Program was signed using the secondary keyr=
ing
>   bpf_keyring=3DPLATFORM    - Program was signed using the platform keyri=
ng
>   bpf_kernel=3DTRUE         - Program originated from kernelspace
>   bpf_kernel=3DFALSE        - Program originated from userspace
>
> These properties map directly to the lsm_integrity_verdict enum values
> provided by the Hornet LSM through security_bpf_prog_load_post_integrity.
>
> The feature is gated on CONFIG_IPE_PROP_BPF_SIGNATURE which depends on
> CONFIG_SECURITY_HORNET.
>
> Example policy for bpf signature enforcement:
>  DEFAULT op=3DBPF_PROG_LOAD action=3DDENY
>  op=3DBPF_PROG_LOAD is_kernel=3DTRUE action=3DALLOW
>  op=3DBPF_PROG_LOAD bpf_signature=3DOK action=3DALLOW
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>

Hi Blaise,

I have not finished reviewing the code yet, so I do not have
implementation comments at this point.

Since this code introduces new policy semantics, it would be helpful
to also reflect that in the IPE documentation, and perhaps include a
link to the Hornet documentation for context.

-Fan
