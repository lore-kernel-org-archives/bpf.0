Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5703D16E3;
	Fri,  5 Jun 2026 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627208; cv=none; b=QQW6Mth2d8lYAQosnLW356Q+c0eNB1kq8uaKdQB0KKmTsnELmxRnBog34/70L9Tn17X9PdRmLl2YPNSxVKecSzeo4xE6ixqltZJsBPCXHUDFWNoM7oG4P4K21nEf91CAZMBz3A3O94/0ebdVrz98wpxQEB/nS1suhG5YHPc0oXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627208; c=relaxed/simple;
	bh=GueZdsUH/+EZ28mId0gTEe7ZJnf767mMV3uecyFh+A8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=d3n08M9APLVL6bPqoZmxgwAC/d2w3n7a6FAMivl9oSEWsvcypkR3OxxoEo+eh/xrx1XhukeIr9REUoSjkbyuwGha8UwJ8cz56NlNxPLzQI8pfqPwChUCWQz/gGBW/ucxfUnzIv7nibGJEMpMsIplEACD0Ag/wv3HQzC+zh6WBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAaLyatX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAaLyatX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65E81F00893;
	Fri,  5 Jun 2026 02:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780627202;
	bh=tllH2akN3DKgD+UoBWgHQAr8zejNajjH9gvNHbzmQz4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=lAaLyatX9St8nhqQo0UQ/9uNMDYC7ERdUrrJ955eaLGC68Q4BEbyJtxCnuOpH+wE5
	 1AXtjz3uALVDPstbGEgr6C4JmW17eY9i7q6PHOttU7s1LkEb13kjC+GrIedR7KrHH3
	 TMM3W6kfQFXT4In1YkR69oD98qyw2eTlyN2GvvIXf/r2svLy5e8ZvvH/qumjpBJuel
	 1JVjXqJzP2s/kGu6Rljo/xOacax6XdcoxSvdK7AmXILmHTulkRyqE6OqtLSRrmWBWL
	 A19ZMy9ZT0N9tLI3+bvJsKgMvRABazLfnw4FJhdiCRPHwCsSpoIt4SSkg+rIA9aXKC
	 EKdzryl/DjZbw==
Date: Thu, 04 Jun 2026 21:40:01 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: weishangjuan@eswincomputing.com, linux-gpio@vger.kernel.org, 
 inochiama@gmail.com, davem@davemloft.net, devicetree@vger.kernel.org, 
 kuba@kernel.org, me@ziyao.cc, hawk@kernel.org, arnd@arndb.de, 
 konradybcio@kernel.org, mohd.anwar@oss.qualcomm.com, hkallweit1@gmail.com, 
 pabeni@redhat.com, ast@kernel.org, maxime.chevallier@bootlin.com, 
 bpf@vger.kernel.org, boon.khai.ng@altera.com, linusw@kernel.org, 
 andersson@kernel.org, sdf@fomichev.me, linux-kernel@vger.kernel.org, 
 livelycarpet87@gmail.com, a0987203069@gmail.com, 
 linux-stm32@st-md-mailman.stormreply.com, daniel@iogearbox.net, 
 john.fastabend@gmail.com, alexandre.torgue@foss.st.com, 
 richardcochran@gmail.com, rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, 
 conor+dt@kernel.org, rohan.g.thomas@altera.com, gregkh@linuxfoundation.org, 
 Daniel Thompson <daniel@riscstar.com>, chenchuangyu@xiaomi.com, 
 andrew+netdev@lunn.ch, mcoquelin.stm32@gmail.com, edumazet@google.com, 
 siyanteng@cqsoftware.com.cn, wens@kernel.org, brgl@kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 julianbraha@gmail.com, netdev@vger.kernel.org, chenhuacai@kernel.org, 
 prabhakar.mahadev-lad.rj@bp.renesas.com
To: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260605010022.968612-11-elder@riscstar.com>
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-11-elder@riscstar.com>
Message-Id: <178062720108.1744752.12164392208085928081.robh@kernel.org>
Subject: Re: [PATCH net-next v2 10/14] dt-bindings: net:
 toshiba,tc9654-dwmac: add TC9564 Ethernet bridge


On Thu, 04 Jun 2026 20:00:17 -0500, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> Add devicetree bindings for the Toshiba TC956x family of Ethernet-AVB/TSN
> bridges.
> 
> The TC9564 contains a PCIe switch with one upstream and three downstream
> PCIe ports.  The third PCIe downstream port has an attached embedded PCIe
> endpoint, and that endpoint implements two PCIe functions.  Each internal
> PCIe function has a Synopsys XGMAC Ethernet interface capable of 10 Gbps
> operation.
> 
> The TC9564 also implements an embedded GPIO controller, which exposes
> 10 lines externally.  Some platforms use these GPIO lines, so this
> GPIO controller is managed by a separate driver.  Other embedded
> peripherals (like a microcontroller, SRAM, and UART) are currently
> unused.
> 
> The GPIO controller is managed by registers accessed via MMIO on an
> internal PCIe function's registers.
> 
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../bindings/net/toshiba,tc9564-dwmac.yaml    | 120 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml: gpio: Missing additionalProperties/unevaluatedProperties constraint
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml: ethernet: Missing additionalProperties/unevaluatedProperties constraint

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
MAINTAINERS: Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml

See https://patchwork.kernel.org/project/devicetree/patch/20260605010022.968612-11-elder@riscstar.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

