Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54840478847
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707122; cv=none; b=NfEpb3vyACRe37BwT/CsRbam/osRp8TUfaL/QoXOokIXLecPb/j8Wdhy/ZyOnxcG75SqgfZt/hGp7gKT7BfbIVTIrxxrUx0Z0kCtruUPiEmzYwDoZ7fxh+knJB0PlSI5I89sDJOCos7Ib6ZUmiv3PvNhYVtm9toKPV9Qa4C53HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707122; c=relaxed/simple;
	bh=HUucXHu8+s63l1s5lkRI3vbh+6RaUP8ekeGXINz8bQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E/FpdCBWpjLnR59koV64XRLt525PkyOsOXsLE/iVK+epU1HJQXDMrcy2t2MN5vmUv8HuAjuBei4GGT7269ftwQpJnYmGx3KO3lJnKyXMU9lBlCJWE1Gmw5/PC0ckzM59SixqC5GICnpVBxkVca5AqyPxSRbE3sKFLUILnl6+7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBz9GSVo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBz9GSVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C733E1F000E9;
	Wed, 22 Jul 2026 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784707121;
	bh=YHymU5sTKGiOlZnHKwaiOqm3tRFV/1otg6YjOvPjkaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oBz9GSVoEv8Ry8sthL1vfEio9P6GgdhyLIVhx+umAI5DYJzOAmf5ggqmt2btzZSW8
	 zKUT1OcynZPvMHP9gt5O5EMPzM6u8UzTitgYkZnQdOrlxDZifXs+RbEx8ObIgh4yGk
	 dEgb3eCiyJkqclayaksePLSgnI6biNMRIh2rYXwHwbV+1WXrQSvd47/oDe/uTaGgeI
	 uRnF7OeXr3oMsnCo9vzWPkzGpUUjiVDniJo1H2AdB6QaJols8SSLZcom4+PFTj02MT
	 jU+sj95nCLUbv6Y/nEidoTamYCIxEHwSTNpZp4Vq+1Qwla7zilepzmLZ47AtYiARHV
	 KzWyGnLb09WDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 5/5] selftests/bpf: Fix potential NULL
 pointer dereference in strscpy call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Yang" <yangfeng59949@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722074748.674080-6-yangfeng59949@163.com>
References: <20260722074748.674080-1-yangfeng59949@163.com>
 <20260722074748.674080-6-yangfeng59949@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:58:40 +0000
Message-Id: <20260722075840.C733E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch prevents a NULL pointer dereference in the worker thre=
ad by replacing a NULL `subtest_state->name` with an empty string, but miss=
es other instances where a NULL `subtest_state->name` causes undefined beha=
vior or crashes (e.g., in single-process mode and server thread IPC parsing=
).
--

--- Patch [5]: [PATCH v2 bpf-next 5/5] selftests/bpf: Fix potential NULL po=
inter dereference in strscpy call ---
commit b6c49e61911a21bc238d913cde0b42bf364476d1
Author: Feng Yang <yangfeng@kylinos.cn>

selftests/bpf: Fix potential NULL pointer dereference in strscpy call

In test__start_subtest_with_desc, if strdup fails or an empty name is passe=
d,
the function returns early. Later, worker_main_send_subtests copies the name
via strscpy, which leads to a NULL pointer dereference.

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
> index ea9c887201aee..ab88268db9e2e 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1882,7 +1882,8 @@ static int worker_main_send_subtests(int sock, stru=
ct test_state *state)
> =20
>  		msg.subtest_done.num =3D i;
> =20
> -		strscpy(msg.subtest_done.name, subtest_state->name, MAX_SUBTEST_NAME);
> +		const char *name =3D subtest_state->name ? : "";
> +		strscpy(msg.subtest_done.name, name, MAX_SUBTEST_NAME);

[Severity: Medium]
This isn't a bug introduced by this patch, but since we are handling a NULL
subtest_state->name here, could a NULL name also cause issues in other plac=
es?

For example, in single-process mode, print_subtest_name() receives a NULL
subtest_name and passes it directly to fprintf() as a %s format argument,
triggering undefined behavior:

tools/testing/selftests/bpf/test_progs.c:print_subtest_name() {
    ...
	fprintf(env.stdout_saved, "#%-*s %s/%s",
		TEST_NUM_WIDTH, test_num_str,
		test_name, subtest_name);
    ...
}

When JSON output is requested, dump_test_log() passes it to the JSON writer:

tools/testing/selftests/bpf/test_progs.c:dump_test_log() {
    ...
			jsonw_string_field(w, "name", subtest_state->name);
    ...
}

This leads to a crash when jsonw_puts() dereferences it unconditionally:

tools/bpf/bpftool/json_writer.c:jsonw_puts() {
    ...
	for (; *str; ++str)
    ...
}

Also, could a strdup() failure in dispatch_thread_send_subtests() lead to
subtest_state->name being NULL again on the server side?

tools/testing/selftests/bpf/test_progs.c:dispatch_thread_send_subtests() {
    ...
		subtest_state->name =3D strdup(msg.subtest_done.name);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722074748.6740=
80-1-yangfeng59949@163.com?part=3D5
