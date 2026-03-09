Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A993A6400
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056817; cv=none; b=OCXIssc+vxfjpyxXXHgx3oxykPpt8PliNPg/+gzUWLl8NFbixGUVycCQdvyleneOMilDeiyo9FmaWIjnE916RS5zLWVvFPb8SEcm4Z3i+rAuIvKsoiQmFE7XMto20sVWMS7tx9MZ0L0/Ty7PMM+ErZTp6RRhq4WViNONfZ4zvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056817; c=relaxed/simple;
	bh=hGRjyFTUo/tFc/SDo2BBMZn6Ono/3kQOwUruOONApUM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=fyWBS6iNwXpnbiYyc5y//0FFvj6m5YShpCaERiNQJA908rFlA7M0EJ7mbTt0QEvpi+v6ynVUvlCPzrfXYppnmEUO6mh3XvVD9nnoseiScYCYZVNleTrNSKKn6LszMO4yR8MloqZilss04h069IK2JNKnXnY7yAUHIUPFYJ6qJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zozr370E; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zozr370E"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773056802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHJak2AClGtNfYUwsfEt8bzDUEvGEbjk0Vje8pMFORU=;
	b=Zozr370E00QI+opnsz7umCy2sLqphlDFAnAaYdwI+HUEi6SrR2VIYDHrIKuE+jKmLTtujF
	4LTbS/Q/309GjXUIK2JmKM93Kb+CbOpAomIw5Bh0IER0xLmwpRGjViuemJli3UJ5Y6oP5R
	7VNCJdz3T1PDj81jo1JBg5u+glZudis=
Date: Mon, 09 Mar 2026 11:46:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <d820cf981c9e6bd83f03f0e2721c531c217dd9d5@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v4 bpf-next] selftests/bpf: livepatch_trampoline: skip
 when prerequisites are missing
To: "Sun Jian" <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah
 Khan" <shuah@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 linux-kselftest@vger.kernel.org, "Sun Jian" <sun.jian.kdev@gmail.com>
In-Reply-To: <20260309104448.817401-1-sun.jian.kdev@gmail.com>
References: <20260309104448.817401-1-sun.jian.kdev@gmail.com>
X-Migadu-Flow: FLOW_OUT

March 9, 2026 at 18:44, "Sun Jian" <sun.jian.kdev@gmail.com mailto:sun.ji=
an.kdev@gmail.com?to=3D%22Sun%20Jian%22%20%3Csun.jian.kdev%40gmail.com%3E=
 > wrote:


>=20
>=20livepatch_trampoline relies on livepatch sysfs and livepatch-sample.k=
o.
> When CONFIG_LIVEPATCH is disabled or the samples module isn't built, th=
e
> test fails with ENOENT and causes false failures in minimal CI configs.
>=20
>=20Skip the test when livepatch sysfs or the sample module is unavailabl=
e.
> Also avoid writing to livepatch sysfs when it's not present.
>=20
>=20Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> v4:
>  - Drop redundant <errno.h> and <unistd.h> includes; both are already i=
ncluded by test_progs.h (per Jiayuan Chen)
>  - Tested: ./test_progs -t livepatch_trampoline -vv (SKIP when livepatc=
h-sample.ko missing)
>=20
>=20v3:
>  - Skip on -ENOENT from load_livepatch() instead of duplicating module =
path logic (suggested by Jiri Olsa)
>  - Tested: ./test_progs -t livepatch_trampoline (SKIP when livepatch-sa=
mple.ko missing)
>=20
>=20v2:
>  - Skip when /sys/kernel/livepatch is missing
>  - Guard sysfs write in unload_livepatch() when enabled knob is absent
>=20
>=20v3: https://lore.kernel.org/bpf/20260309033712.728133-1-sun.jian.kdev=
@gmail.com/
> v2: https://patchwork.kernel.org/project/netdevbpf/patch/20260305030258=
.5273-1-sun.jian.kdev@gmail.com/
> v1: https://patchew.org/linux/20260227042354.20926-1-sun.jian.kdev@gmai=
l.com/
>=20
>=20 .../bpf/prog_tests/livepatch_trampoline.c | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
>=20diff --git a/tools/testing/selftests/bpf/prog_tests/livepatch_trampol=
ine.c b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
> index 72aa5376c30e..0a12af924a99 100644
> --- a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
> +++ b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
> @@ -5,6 +5,8 @@
>  #include "testing_helpers.h"
>  #include "livepatch_trampoline.skel.h"
>=20=20
>=20+#define LIVEPATCH_ENABLED_PATH "/sys/kernel/livepatch/livepatch_samp=
le/enabled"
> +
>  static int load_livepatch(void)
>  {
>  char path[4096];
> @@ -19,7 +21,8 @@ static int load_livepatch(void)
>  static void unload_livepatch(void)
>  {
>  /* Disable the livepatch before unloading the module */
> - system("echo 0 > /sys/kernel/livepatch/livepatch_sample/enabled");
> + if (!access(LIVEPATCH_ENABLED_PATH, F_OK))
> + system("echo 0 > " LIVEPATCH_ENABLED_PATH);
>=20=20
>=20 unload_module("livepatch_sample", env_verbosity > VERBOSE_NONE);
>  }
> @@ -81,9 +84,22 @@ static void __test_livepatch_trampoline(bool fexit_f=
irst)
>  void test_livepatch_trampoline(void)
>  {
>  int retry_cnt =3D 0;
> + int err;
> +
> + /* Skip if kernel was built without CONFIG_LIVEPATCH */
> + if (access("/sys/kernel/livepatch", F_OK)) {
> + test__skip();
> + return;
> + }
>=20=20


I=20think Jiri's suggestion in v2 means that you should drop the path che=
ck=20
here=20and in unload_livepatch() and just keep checking -ENOENT.

-ENOENT returned by load_livepatch() means the ko doesn't exist,
which happens when either CONFIG_LIVEPATCH is disabled or livepatch_sampl=
e=20
is=20not compiled.


>  retry:
> - if (load_livepatch()) {
> + err =3D load_livepatch();
> + if (err) {
> + if (err =3D=3D -ENOENT) {
> + test__skip();
> + return;
> + }
> +

>  if (retry_cnt) {
>  ASSERT_OK(1, "load_livepatch");
>  goto out;
>=20
>=20base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> --=20
>=202.43.0
>
