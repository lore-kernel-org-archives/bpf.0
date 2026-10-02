Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C621F938;
	Fri,  2 Oct 2026 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900726; cv=none; b=CXd+JWhJHcKjBTnrS//aETRllqBqmdXegQhrNWYUWWuklBVWNenTTaqyX89bRYceRUVmaZGio/8+f9R+JYK3fgIn/I8RxhHbyf2vB/oHC2wUly1jIF9Pl+8ORxew9584U9CMZdaSWpU9JN3w5RgO2neo3toNZhlGQ9+hSiIiquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900726; c=relaxed/simple;
	bh=KDsWbS0Elry7eL2lW1U1AZfsNXSRE9lCM5nN708j6CI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XA2rY7ghUjCNmjvKnHRokMNJ/YYfLDk7k8pzmyXAhC2GwD0Q52x0EEC+LMJiH78zEJe2fI3At/vGXaDmMZnKBclqxYQHuOEiNEiLqtP/qk3EYKFfbOgJkqGEtxwbn2Kiy7nwI3rpBo6H+A9eWdKXMWgOIppHsTnc75GYP2OZF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXRnKH+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXRnKH+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB941F000FF;
	Fri,  2 Oct 2026 00:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790900725;
	bh=e6ucH4pE0/4sZL+8neWjc294yEbL1d8sfOaBwN6QaEw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mXRnKH+nt9ih5wtG/5UOeTjtSMs1qaN0CsqNUdGpV7Z0Ep1W3t3kdyZIABz7xNb5+
	 jvceI0FBuLBdLWTav0ttU3s8w6Z+nj63yO1mNi6cCaxNjewLs8kZJNCRZpf/NmELUu
	 UcZwCF+CJX3jSGT8UY5VhpozoijhNNUzWOC5jn+fGjXo9vvwGReC1m9HEO7E50QugB
	 r3OYEHk9hCLugX6jHMnwhWF4u6zf7+bCZxFR9wcC0PmBfZC/g1enNAAEsGBSG7VZGV
	 vvovlgx9Cipyvq9TSnn4Xbo7kIwtyYZlUAhZQksAt+P8JTcjmwuNxUr25yW29DYu81
	 64q9Wcud6weoA==
Content-Type: multipart/mixed; boundary="===============1186257611127603077=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7879b2bd10707aa28e33dd50e86230b4e42968b534c4c4edb1866706e1bf24c3@mail.kernel.org>
In-Reply-To: <20261001152042.124445-14-gmonaco@redhat.com>
References: <20261001152042.124445-14-gmonaco@redhat.com>
Subject: Re: [PATCH v2 13/15] verification/rvgen: Add support for BPF monitors
From: bot+bpf-ci@kernel.org
To: gmonaco@redhat.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,bpf@vger.kernel.org,rostedt@goodmis.org,gmonaco@redhat.com
Cc: alexei.starovoitov@gmail.com,namcao@linutronix.de,wen.yang@linux.dev,tobias.schaffner@siemens.com,vmalik@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 00:25:24 +0000 (UTC)

--===============1186257611127603077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> verification/rvgen: Add support for BPF monitors

TL;DR: In rvgen, with -b and -a, the printed messages and checklist point to a
nonexistent {monitor.name}/ directory and never say the sources went to
bpf_monitors/. Should they print that location?

> diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
> --- a/tools/verification/rvgen/__main__.py
> +++ b/tools/verification/rvgen/__main__.py

[ ... ]

> @@ -80,7 +85,9 @@ if __name__ == '__main__':
>      print("Almost done, checklist")
>      if params.subcmd == "monitor":
>          print(f"  - Edit the {monitor.name}/{monitor.name}.c to add the instrumentation")
> -        print(monitor.fill_tracepoint_tooltip())
> -    print(monitor.fill_makefile_tooltip())
> -    print(monitor.fill_kconfig_tooltip())
> -    print(monitor.fill_monitor_tooltip())
> +        if not params.bpf:
> +            print(monitor.fill_tracepoint_tooltip())
> +    if not params.subcmd == "monitor" or not params.bpf:
> +        print(monitor.fill_makefile_tooltip())
> +        print(monitor.fill_kconfig_tooltip())
> +        print(monitor.fill_monitor_tooltip())

With -b and -a, does this checklist point to a path that is never created?

RVGenerator.__create_directory() returns early for this case:

    if self.auto_patch:
        if self.bpf:
            # no directory for BPF monitors
            return

and RVGenerator._create_file() writes the files to self.rv_tool_dir, which
resolves to tools/verification/rv/bpf_monitors/<name>.c in the kernel tree:

    if self.bpf:
        path = Path(self.rv_tool_dir) / file_name

But __main__ still prints "Writing the monitor into the directory
{monitor.name}" and "Edit the {monitor.name}/{monitor.name}.c to add the
instrumentation", and no {monitor.name}/ directory exists anywhere.

Since fill_monitor_tooltip() is now skipped for BPF monitors, which on the
in-kernel -a path prints "Monitor created in {rv_dir}/monitors/{name}",
nothing in the output tells the user where the generated sources were
written.  Should the BPF -a case print the bpf_monitors/ location instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36944413541
--===============1186257611127603077==--
