Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0E20ED
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674303; cv=pass; b=jcxK6XOVKjwStt2JMHSoLmOh6jHx99G793iCpzbzNETgMHkc2kCE0F5cGMgUSCsbHk6/0Hv6toDQYHd0slSCcfIPIgLENO0lq/seecYGLAyqBree8Dd2BEdBe2mOSgMcwcjYGSWBOG17IzgW2PC0OaQtZ4+SwDBEzbWYh1VHr4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674303; c=relaxed/simple;
	bh=FzeXFe0QvmpsSjZVScEEuXwGhL5+6ueJsl70Abgc3WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szU3YAAPm+bsVQc3XakrhknG9fVxA2l1FSM1ypNFk5KQlJOb8LVsIZgJLG9Yd9n9CfSCX0FMiTNMFGYGH1LygSj32YyGSmnz9QfNgV81OlnkXbCgXu+766YFShy4CtHCSsS7V8TjlkDikv3P+JLNP1wDYNvhjzXMp2DwtTT10bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9e8BU8R; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9e8BU8R"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8fd976e90cso947690066b.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 17:31:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772674300; cv=none;
        d=google.com; s=arc-20240605;
        b=GVtmaxjHq24TdkKByKPsMwxerRiFHApJESNzBf04NmufCiw7KWFPr0C/tlXZNgPvbH
         XhajvKkOOTyxDU+fan4FvkAACYZG0cgkf9QSQmbY0qcWOB+gUHpG0aBRMiD6/v35cBOk
         Ds/Q2Sy2ItMVyBwiztlqa34Oy4EgHaOAyxKA6TkpX9tI/bamUhxGYrkZH6fBFDLwq6rM
         jS64XVd/LZMvkxZrunp6StSYJ8xM/p0BzzBdgLPjVspG81IWFgGVQcf4NmMhWlrfURCz
         vUOJsrOUIOweYQgTYxw/LYv7b91RzzCpjBK84WpFawCw7FVV5m9KJ1+XwfrEelQrdOLk
         hFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zjpbkErOHnmzrleuvB8p/5mk+s2hfkdeYZi5w75/lRM=;
        fh=fAaOfq7WKFB4hwl7tHu40Hh5ivGFTjxTT4XqN5ZvuLQ=;
        b=J9MCZMFF1weN+yU7FPRltCziZzGZxGmX++xOYvU6SI4/LpSdWNTaBtRVED7LtgT3ma
         pEY24Jk5JgPEd9KrEEooW/kWc8wDJAVccfu9OWilvE8fTqkJnB5u6aShc3Utw3IYjtQB
         0XdFunpVZMeC4zm+0Uy54tIrZH8Mx5ALXBvasf1TwzKPH7dcDyvWtsi4A063ewk+yJJZ
         zmZZ8Clawm8E8OjXn+AnrjONskwmu4UeDLt6CHYBiTaAQdErM5xSqOgbG8Vm4T51B3N8
         W0iYLHW3z23voROuCZlFRSXboUBh4xit8cq8pwUriq8iVPABHr33kL7wOVaibeK77+TB
         iw2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772674300; x=1773279100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjpbkErOHnmzrleuvB8p/5mk+s2hfkdeYZi5w75/lRM=;
        b=s9e8BU8RLZJRDsFT+ivDFGoP7tvhrjXWq/QnrorauxGLn0LEH6VPaHP0PhZvyrrmzL
         roEX45tT7KeZssj9UJ0MivCyBXjYGbvIy7heoOUf1OePAX5bzcOmZBVTW+eo2P+8K1WD
         8ie33tO9NTmPUomn+uVoZ3KmOrn3q5C5vCGfzL1fLUKS5csI866FhioHlky6QVAyZYxy
         8/nlhHyWsovT51RsqkGlDXEsmx4ejRWu0Yl5C9ij+W2YyJNEVFfcPFSLUswWyuFZOnPr
         y/tP2oQTi2yvOG1tonYtdbIPZwUjkJpNLbvRTdKFUS039x1XpMBgCGndzjKREBS2owEH
         KGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772674300; x=1773279100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zjpbkErOHnmzrleuvB8p/5mk+s2hfkdeYZi5w75/lRM=;
        b=BELVJ17rUjhQqboOcc8gzkGPyy+RLUyTKru6Da/HCTWj9qjxKBv3Y/z4DY6kHMJY9y
         yosuGmhKb5E+WXU9kr3N2lbwBBhrhz2xEfbYCdVAL0tBBdTsgUZgJXCnjekYhyfpq/C5
         5L8r3R6+KYdgHiCud4QKGdp5akdszxMJMlhawMT10oUETSNgsCBFc67nqW8lcRIWK3+9
         6p79tKz7ViS3CUM0ttG4atGOaxuxo67PHu4SrIOJhVwxgpG7+YSSzJiCDr49UQYLoZa8
         ozmDz95713YpvHifhxsDDzfZI7Kw/43KuReHDot/3XD2kybR48F0ruKqqlYblld+Inye
         Kyyw==
X-Forwarded-Encrypted: i=1; AJvYcCVXavf+H2hbY0yPyAiKxJvqEmHXgXlWo/DEM7Sak1SavzA1auEoD2H/GpA8kVftMV05iRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SF283J7QEjtny8laCedr9hsqjwoKCXU2Ps5uIziSzuNCwx/l
	Wn7HcifBqBRuhoptZwWa+2IarXJk642q1x+nBFXQ1YFT/wpQpGe8eAZccToqp59qB5XdzbBZ4T+
	ZJdLnsmbr4NiFVcRpJSKmbvPCz56O1wx+EN7CjbrN
X-Gm-Gg: ATEYQzxaBx588DGYEY4zuvWgGyH7w+IfXCnLkQ8liH04lO7ItcvOYoAaR00DN/w9Grd
	CBENDnHdpo3O6q5Ot3W5NisXzb4sPBPyDghT6vPI0OLnqUDS8wBZvzyNqCl2iyveB0oYFGRh4Ky
	UYAPCDOu3IsrQeYJgs7UDc5ZPh11jayre78LqWqeBCfoY4N4r4jTr7Io4UdWV1FD6Glgq/U0FjA
	digigexs5Pq2RL6BtD822lDSiaETQKSsQLE43DWRuIgVsiVfGa/4v0BK8IQ7cNdlT/oVQ5nlIfu
	xWLE8HfoRszvlSgageLM7+OBYNTobevG7QmhEw==
X-Received: by 2002:a17:907:97c4:b0:b87:117f:b6ed with SMTP id
 a640c23a62f3a-b93f11d4fe9mr282867266b.21.1772674299780; Wed, 04 Mar 2026
 17:31:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225210820.177674-1-wusamuel@google.com>
In-Reply-To: <20260225210820.177674-1-wusamuel@google.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 4 Mar 2026 17:31:27 -0800
X-Gm-Features: AaiRm52C5xBdZIqfueKu2tL60CZqMfP-hQL6ZTxgaS55rDUh5TRWZ_Zruir6wkY
Message-ID: <CAG2Kctp1q1QtB1-JT2cgBsYu-WceV1YdSM1sSwNm8pyGtZQ6TA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/2] Add wakeup_source iterators
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 1:08=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> This patch series introduces BPF iterators for wakeup_source, enabling
> BPF programs to efficiently traverse a device's wakeup sources.
>
> Currently, inspecting wakeup sources typically involves reading interface=
s
> like /sys/class/wakeup/* or debugfs. The repeated syscalls to query the
> sysfs nodes is inefficient, as there can be hundreds of wakeup_sources, a=
nd
> each wakeup source have multiple stats, with one sysfs node per stat.
> debugfs is unstable and insecure.
>
> The iterators utilize pre-existing wakeup_sources_walk_* functions to
> traverse over the SRCU that backs the list of wakeup_sources.
>
> Changes in v5:
>  - Add CORE definitions for *__local variables to fix s390 build per bpf-=
ci
>  - v4 link: https://lore.kernel.org/all/20260211235055.239024-1-wusamuel@=
google.com/
>
> Changes in v4:
>  - Proper init of variables in ws_iter_check_sleep_times() test per bpf-c=
i
>  - Remove PM patch since it's already part of rebase
>  - v3 link: https://lore.kernel.org/all/20260124012133.2451708-1-wusamuel=
@google.com/
>
> Changes in v3:
>  - Update wakeup_sources_walk_start() to handle an empty list per bpf-ci
>  - Simplify read of a struct's field in BPF program selftest per Andrii
>  - Drop open coded iterators for wakeup_sources
>  - Fix condition from !get_ws_iter_stream to get_ws_iter_stream in selfte=
st
>  - Read event_count instead of wakeup_count in selftest
>  - v2 link: https://lore.kernel.org/all/20260108225523.3268383-1-wusamuel=
@google.com/
>
> Changes in v2:
>  - Guard BPF Makefile with CONFIG_PM_SLEEP to fix build errors
>  - Update copyright from 2025 to 2026
>  - v1 link: https://lore.kernel.org/all/20251204025003.3162056-1-wusamuel=
@google.com/
>
>
> Samuel Wu (2):
>   bpf: Add wakeup_source iterator
>   selftests/bpf: Add tests for wakeup_sources
>
>  kernel/bpf/Makefile                           |   3 +
>  kernel/bpf/wakeup_source_iter.c               | 103 ++++++
>  tools/testing/selftests/bpf/config            |   1 +
>  .../bpf/prog_tests/wakeup_source_iter.c       | 300 ++++++++++++++++++
>  .../selftests/bpf/progs/wakeup_source_iter.c  |  80 +++++
>  5 files changed, 487 insertions(+)
>  create mode 100644 kernel/bpf/wakeup_source_iter.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_=
iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.=
c
>
> --
> 2.53.0.473.g4a7958ca14-goog
>

Hi Andrii, any thoughts on this patchset? I've addressed your
suggestion from v2 of this patchset regarding selftest, but nothing
fundamental has changed since then.

Thanks!
Sam
