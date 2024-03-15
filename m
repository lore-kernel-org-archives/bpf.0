Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C11199B0
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498672; cv=none; b=Jfu0D0LDDtRFFrCwGUpyr0EFEuXk731XweOcE0oWi2+5R2IPQ/Nejts2jg1Q/AwiBVpT3rEUH1509rppAxeyoBVDZa6qxDgeItPqP8Jw4mswui/P52xcmGrSjhoWJrA8zpFKUc6OwhYzCEG1owJRiZ6Cy/0DiepaeChkqkuv0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498672; c=relaxed/simple;
	bh=pCSdVqVmSQviFBt1f4k4YRD+LgSZCsFIqbE7ndGXexk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+QE/7d5NmVQe/tm3QDL3gHJcBaJfe7E2Tb8ddslxujAugHZuClbX+sEDNnNxU6JM5ZzyXzdN2J76ZL75mh/LnyVvtfA2jRgNxr1GylHQwGyzoMaSgyrcaOU4YKAaBe4IQkN+s6lp7GwPYjloUW+5eGMGiiJQqXG6RThl2ZXWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA2EUE2P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA2EUE2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55786C433C7;
	Fri, 15 Mar 2024 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710498671;
	bh=pCSdVqVmSQviFBt1f4k4YRD+LgSZCsFIqbE7ndGXexk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aA2EUE2PPfWH7xkmHYcGy/PFijsnsCCf0AWQI+z/OWEfmAN8V7SE152fjAGQguovX
	 QP1Nq3RCxvNZ0I06zwyVSg0la2Xdd/5lDX+X0qZx2CgsP7sxGIin8TI6VbxBKn0hUM
	 P2AyVq311HO5bB0XGiRX/mGa5/5POQ1HBp/8ZaFW5vgoVsoNC3wgY05aS6Ha6MaKwX
	 scP2NtNtYkDSNNZULEM+yZpKiCbGU9JjTP3eEMpIhUpPkWRD+kQNqiOqPDptULiJFb
	 U7CKBwhp9ke58EQFv2WNI9KqllHvulDDDFFjbmg4hEpqg3utZcH2+gdcyRxLojQ628
	 obz6KcW/b49bQ==
Message-ID: <bccbfd38-3f1f-411e-aeab-70d256d896dd@kernel.org>
Date: Fri, 15 Mar 2024 10:31:02 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf_doc: use silent mode when exec make cmd
Content-Language: en-GB
To: Hangbin Liu <liuhangbin@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Alejandro Colomar <alx.manpages@gmail.com>,
 Michael Hofmann <mhofmann@redhat.com>
References: <20240315023443.2364442-1-liuhangbin@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
In-Reply-To: <20240315023443.2364442-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-15 02:34 UTC+0000 ~ Hangbin Liu <liuhangbin@gmail.com>
> When getting kernel version via make, the result may be polluted by other
> output, like directory change info. e.g.
> $ export MAKEFLAGS="-w"
> $ make kernelversion
> make: Entering directory '/home/net'
> 6.8.0
> make: Leaving directory '/home/net'
> 
> This will distort the reStructuredText output and make latter rst2man
> failed like:
> bpf-helpers.rst:20: (WARNING/2) Field list ends without a blank line; unexpected unindent.
> 
> Using silent mode would help. e.g.
> $ make -s --no-print-directory kernelversion
> 6.8.0
> 
> Fixes: fd0a38f9c37d ("scripts/bpf: Set version attribute for bpf-helpers(7) man page")
> Signed-off-by: Michael Hofmann <mhofmann@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  scripts/bpf_doc.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index 4606944984ee..c55878bddfdd 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -414,8 +414,8 @@ class PrinterRST(Printer):
>              version = version.stdout.decode().rstrip()
>          except:
>              try:
> -                version = subprocess.run(['make', 'kernelversion'], cwd=linuxRoot,
> -                                         capture_output=True, check=True)
> +                version = subprocess.run(['make', '-s', '--no-print-directory', 'kernelversion'],
> +                                         cwd=linuxRoot, capture_output=True, check=True)
>                  version = version.stdout.decode().rstrip()
>              except:
>                  return 'Linux'

Reviewed-by: Quentin Monnet <qmo@kernel.org>

This can probably go through bpf-next, though.

Thanks!
