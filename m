Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A403E277E
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650911; cv=none; b=uGk+lvTKdbvdSEY3rhZv/bKz99f5jErf3D3zOWtA7n/s9dp0bug1JoBk/Ud5vaZSd4FY+jrl2F7QXVIusoUBZt6JDp9K/ZJlNL1l0+CK7Wpei4XNr058uKvUh7rsrPkP5hW03Lcr/uc29MR2vMeiCmyGY+MJ+m69y9u9e5x4iac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650911; c=relaxed/simple;
	bh=Z3xqXDkBWFDdyrtPSGEDjKxF9Td/NrtBzEpnN319gkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjA9RebMQ0kyNB0SuIX6tE2ZMfgYsgpiDn7638uFCRqTNuv2Dlgsv53K823njOXfqKw1bBbKftk5LAu0zhatnNCkSl1FXyQOCqgNZ3vniDfEqd1D6qNG6YJOdbbjwVTWQWreNiX5bKFFt2ldM2z5MoQEpAP6OVkvip75EJjOlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=DzA+Q4su; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="DzA+Q4su"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d4f78fc9f6so214154785a.3
        for <bpf@vger.kernel.org>; Fri, 01 May 2026 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777650908; x=1778255708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK9EvvjSLddFpBQK0gJ5r1hHzJCQAPB+JE9l90vZOLA=;
        b=DzA+Q4su2yvvRRfMmG+pvSbNjFjSOXqlTNDv2P1wKy3VqX3Giec9uHfh6wKNN3xBMT
         s0nTgTX8lQduq6gsuReitPP84qqxFS87Bn9ISaQn145+5vwCWvKfZEMTNkXLFuWk82Qt
         Ut+pbrkg+w2cEFS464mPqZ1oZLowayqXHYJiSYrlJEjhRjXzkdKX9J4eo4V77MHXYKb8
         6HJM05xWbO0itdNawm2D6cpUtXHhR99PT3HW9h1EG7dRH7ceqRgiL/bvOy67WOKZqGIo
         wvfBNR2JzFzWucDFOm+Arni3unStcelYJP/vUdY3m3TEBf8ji3ag5NbqOr4nwHy8XJ1F
         40Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650908; x=1778255708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sK9EvvjSLddFpBQK0gJ5r1hHzJCQAPB+JE9l90vZOLA=;
        b=ZYk877MFHBUIEsFfiiXC5VjCjx5xRuk/LHEj+QfmGP3PY3f1LSFbdxl2Jgqym5Dw12
         DTccVXInNPQx0/qoc8lwgNxPf8qBozLZ369lW7eieabshn7phCSgJ5jM6bhGf6Y1y2RS
         aYDG0llzk5RAriyzXe3ibFf14OJzyPJbPZIQqZQwkJUEAvZSAgY2qO/EG6XfBrrKiSVE
         jKcZm5uNbvSOC7xE403DR7Uf+fTCwUpFb5Jjz8tur9e0sA0361XuslhtTXzVuVzOleeN
         THOLCdRbdEZiiVf+02fBlL8/MAGGapzU6ba2d/PAGh6UThkybCT16lgXVkNPbRfx6Yln
         LxJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GSLrebrv+znBDm4vRnxiEO5tLLhb5CX7Ok5yAbD5xqrAJSztDWM3bHrD47mZKo1bpTUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXieNAtMA+ll0B5IA9XnLK6f4TvhlO59uxbVIbAkF0xjTTUGwm
	88tpUtaMTWnZlLMFCr/vhnsDQmChkV9lQ4PfktP0j6PbhUrGZC05V/2aHCDVtmPseKw=
X-Gm-Gg: AeBDiev6ZTrG4638WG1ByCugo6Crz4PsPeOhu4zjxGNFCz0wrNno1dM1V2cDjmfAn+R
	seb3Xnc6Wh4NBJiiVldp6UXduIJz+cWxqUdeSYzaluh9wO94lrFRhyt6WXJhqHc5v6zxyYO92Jc
	Tmqb16NvgDQo4q9/6p32+LmfzY373kHZHdMxuG+YYJ+tyjG9nAMIP3qpK2WmQ8O2Pwr0BX3Izyc
	JpVUAeYFgkMx3NiihSvEMlfVXx3nvQyp6W8jqGNeNbdAUF9PBxdjS8Jpfe1iESL/1weSkqxD0ho
	QxFHFfqePmu7Mlz7QvHAeLDFmZofY+TUFcx3b+I0Q/Eoc4rTEQfz8q67xfh2nBN4QRRwFl7Abqd
	SagaSUWqK0eXyX+Af74jmO1q1uS1hN8htUGYz/CnQ7C37y6U9BbA0rTWhEsh2e6lbXpDqU1La2r
	4a/EXMcqmvgPP6/0gdosqTpGqR5ei6u0zM8PqLo3ImMro23tcjiu15dYx0asIqxpX90FCCt/HmR
	A+2pA==
X-Received: by 2002:a05:620a:171e:b0:8cf:f215:24c6 with SMTP id af79cd13be357-8fa86db71dcmr1150937585a.21.1777650908306;
        Fri, 01 May 2026 08:55:08 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm26615406d6.22.2026.05.01.08.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:55:07 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	matthew.gerlach@altera.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 12/12] arm64: dts: qcom: qcs6490-rb3gen2: enable TC9564 with a single QCS8081 phy
Date: Fri,  1 May 2026 10:54:20 -0500
Message-ID: <20260501155421.3329862-13-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260501155421.3329862-1-elder@riscstar.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

The QCS6490 RB3Gen2 includes a Toshiba TC9564 (a.k.a. Qualcomm QPS615).
TC9564 is an twin Ethernet-AVB/TSN bridge with an integrated PCIe switch.

There are multiple builds of RB3Gen2 with components included/excluded.
That means whether or not there is a phy attached to eMAC0 depends on
the exact board. However all versions include a TC9564 combined with a
single QCS8081 attached to eMAC1.

Add properties to the existing PCI nodes to describe how the TC9564 and
QCS8081 are connected to each other (and to the host SoC).

(Note: "pci1179,0220" is documented in the "net/toshiba,tc956x-dwmac.yaml"
binding, but checkpatch.pl doesn't recognize that.)

Co-developed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 45 +++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index e393ccf1884af..72c89aa7a2e43 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -308,6 +308,16 @@ vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
 		regulator-enable-ramp-delay = <10000>;
 	};
 
+	qep_1p8: regulator-qep-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "qep_1p8";
+		gpio = <&pm7325_gpios 8 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	wcn6750-pmu {
 		compatible = "qcom,wcn6750-pmu";
 		pinctrl-0 = <&bt_en>;
@@ -937,20 +947,46 @@ pcie@3,0 {
 			ranges;
 			bus-range = <0x5 0xff>;
 
-			pci@0,0 {
+			tc956x_emac0: pci@0,0 {
+				compatible = "pci1179,0220";
 				reg = <0x50000 0x0 0x0 0x0 0x0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
 				ranges;
+
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pci@0,1 {
+				compatible = "pci1179,0220";
 				reg = <0x50100 0x0 0x0 0x0 0x0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
 				ranges;
+
+				phy-mode = "sgmii";
+				phy-handle = <&tc956x_emac1_phy>;
+
+				mdio {
+					compatible = "snps,dwmac-mdio";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tc956x_emac1_phy: ethernet-phy@1c {
+						compatible = "ethernet-phy-id004d.d101";
+						reg = <0x1c>;
+						reset-gpios = <&tc956x_emac0 1 GPIO_ACTIVE_LOW>;
+						reset-assert-us = <20>;
+						reset-deassert-us = <20>;
+
+						pinctrl-names = "default";
+						pinctrl-0 = <&qep_irq_pin>;
+						interrupts-extended = <&tlmm 101 IRQ_TYPE_EDGE_FALLING>;
+					};
+				};
 			};
 		};
 	};
@@ -1524,6 +1560,13 @@ usb_hub_reset_state: usb-hub-reset-state {
 		drive-strength = <2>;
 		bias-disable;
 	};
+
+	qep_irq_pin: qep-irq-state {
+		pins = "gpio101";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
 };
 
 &lpass_audiocc {
-- 
2.51.0

