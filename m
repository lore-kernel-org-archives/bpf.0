Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41854CF70;
	Tue,  8 Sep 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883313; cv=none; b=mDlBQurxthugFINRPd1Jgn7nwPVg+50LbSazDEWwaLTK8ldcKJ/wTZQotPeBDM7UmJ4guOu7aQOxD1ufyKbQYBtEa7VWkW35FyMCHLM4nQSWvxSAapjacuUVYLD3auvHAJRHD8YQz67vIXXoggfE1lD19U14tM+ZKlV+9BY8WfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883313; c=relaxed/simple;
	bh=mZ2j5QOkE/HLnGIi0XE+hmpgBN1zSN9U6Agmkcnpk1U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Tr2bocVjJ1if5kf6Dc0qSaZgDupHrXR/nVgCUyrBsaTH1dtybs77cbrbBt3uN/sHxDedZGh6aC9giEH+OiuhwCJC6LL1CQuXLl7z3/KzMSEAhEIo+jtEbPgkxj9doNAkBiQzTsbcMWrkgY9phLtPpaGW61Jl+aGsRZiyBD8sG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jrb0D6Ny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jrb0D6Ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF79C1F00A3D;
	Tue,  8 Sep 2026 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883311;
	bh=BT0eMPiY4NnJmGV31mLExbYAagXnqjJF9EYkFecTOYo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Jrb0D6NyT4RW6WjtWwbU2Dt2TTqD+/zjEqrh3E6pXJPY45fevt5lRNQsuFPx2Wyx6
	 0jJKLwcYMo3dcJ+MtaP4pFPxMp1jALxZlGXN9f+OOspsV52inSlTElWT2LDLOvkdYd
	 tn820MMMMr2OwZqe6jpu760cEkjACQpMW/A4e+4X2iVGCB+MujyH+cNisCpWJy1SuJ
	 qFUOegA5+SbDr+l29WUOkYRLdOH6vWQpKss8sT/1shLBF/Cu7pyABPot7086lQ5wgW
	 dZG4ch/yROUt4WCb8DqTHRLPQFUfZH5faWnMA70dDzZAP/J5/qwP+m++Mk7NVwo2w0
	 tgYs+RAx4/BtQ==
Content-Type: multipart/mixed; boundary="===============5302876165755269338=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <70e2a2f4354a7eb6208944e1ab2c13dadcb8b78cdbe2888ad4471124b1cc81b7@mail.kernel.org>
In-Reply-To: <20260908065529.901593-1-tweek@google.com>
References: <20260908065529.901593-1-tweek@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: Skip non-autoload programs when generating light skeletons
From: bot+bpf-ci@kernel.org
To: tweek@google.com,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org,tweek@google.com,kpsingh@kernel.org,leon.hwang@linux.dev,emil@etsalapatis.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  8 Sep 2026 16:01:49 +0000 (UTC)

--===============5302876165755269338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> index d0a36f442db7..1cdecf3e4fa5 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst

[ ... ]

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a50540ef6521..0fcfe20ff515 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -583,6 +583,9 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
>  	bpf_object__for_each_program(prog, obj) {
>  		const char *tp_name;
>
> +		if (!bpf_program__autoload(prog))
> +			continue;
> +
>  		codegen("\
>  			\n\
>  			\n\

[ ... ]

> @@ -1339,6 +1348,8 @@ static int do_skeleton(int argc, char **argv)
>  		map_cnt++;
>  	}
>  	bpf_object__for_each_program(prog, obj) {
> +		if (use_loader && !bpf_program__autoload(prog))
> +			continue;
>  		prog_cnt++;
>  	}

Can the autoload flag change between when this check runs and when
codegen_attach_detach() checks it?

Looking at the code flow, do_skeleton() samples bpf_program__autoload() here
before calling bpf_object__load(), but codegen_attach_detach() and
codegen_destroy() (which also check autoload at gen.c:586, 635, 654, and 686)
run inside gen_trace() after bpf_object__load() completes.

In tools/lib/bpf/libbpf.c, bpf_object__load() ->
bpf_object_prepare() modifies prog->autoload for struct_ops programs:

1. bpf_object__init_kern_struct_ops_maps() (libbpf.c:1251, 1290) sets
   st_ops->progs[i]->autoload = false when the member is missing from kernel
   BTF or the slot was replaced/NULLed.

2. bpf_object_adjust_struct_ops_autoload() (libbpf.c:1166) sets
   prog->autoload = should_load for programs referenced by struct_ops maps,
   which can flip SEC("?struct_ops/...") programs from false back to true when
   the referencing map has autocreate set.

For the false->true case (SEC("?struct_ops/foo") with an autocreated map):
do_skeleton() omits both the progs and links struct fields, but
codegen_attach_detach()/codegen_destroy() then emit attach functions
referencing skel->progs.foo.prog_fd and skel->links.foo_fd, which weren't
declared.

For the true->false case (plain SEC("struct_ops/foo") whose member is missing
from kernel BTF): the fields are emitted but attach/detach/destroy skip the
program, and the loader doesn't reserve a prog_fd slot for it, so subsequent
program FDs get written into preceding fields.

Would it work to sample autoload once and reuse that decision, or to move the
struct field emission after bpf_object__load()?

> @@ -1402,6 +1413,8 @@ static int do_skeleton(int argc, char **argv)
>  	if (prog_cnt) {
>  		printf("\tstruct {\n");
>  		bpf_object__for_each_program(prog, obj) {
> +			if (use_loader && !bpf_program__autoload(prog))
> +				continue;
>  			if (use_loader)
>  				printf("\t\tstruct bpf_prog_desc %s;\n",
>  				       bpf_program__name(prog));

[ ... ]

> @@ -1415,6 +1428,8 @@ static int do_skeleton(int argc, char **argv)
>  	if (prog_cnt + attach_map_cnt) {
>  		printf("\tstruct {\n");
>  		bpf_object__for_each_program(prog, obj) {
> +			if (use_loader && !bpf_program__autoload(prog))
> +				continue;
>  			if (use_loader)
>  				printf("\t\tint %s_fd;\n",
>  				       bpf_program__name(prog));


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34245369055
--===============5302876165755269338==--
